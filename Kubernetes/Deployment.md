# Deployment
## Deployment는 Pod 배포 자동화를 위한 오브젝트
- 새로운 Pod를 롤아웃/롤백할 때 ReplicaSet 생성을 대신해준다
## 롤아웃 배포전략
- Recreate
    - 이전 Pod를 모두 종료하고 새로운 Pod를 replicas만큼 생성
    - 컨테이너가 정상적으로 시작되기 전까지 서비스하지 못함
    - replicas 수만큼의 컴퓨팅 리소스 필요
    - 개발단계에서 유용하다.
- RollingUpdate
    - 새로운 Pod 생성과 이전 Pod 종료가 동시에 일어나는 방식
    - 서비스 다운 타임 최소화
    - 동시에 실행되는 pod의 개수가 replicas를 넘게 되므로 컴퓨팅 리로스가 더 많이 필요하다. 

### RollingUpdate 속도 제어 옵션
- maxUnavailable
    - 롤링 업데이트를 수행하는 동안 유지하고자 하는 최소 Pod의 비율을 지정할 수 있다.
    - 최소 Pod 유지 비율 = 100 - maxUnavailable 값
    - ex) replicas: 10, maxUnavailable: 30%
        - 이전 버전의 Pod를 replicas 수의 최대 30%까지 즉시 Scale Down 할 수 있다.
        - replicas를 10으로 선언했을 때, 이전 버전의 Pod을 3개까지 즉시 종료할 수 있다.
        - 새로운 버전의 Pod 생성과 이전 버전의 Pod 종료를 진행하면서 replicas 수의 70% 이상의 Pod을 항상 Running 상태로 유지해야 한다.
- maxSurge
    - 롤링 업데이트를 수행하는 동안 허용할 수 있는 최대 Pod의 비율을 지정할 수 있다.
    - 최대 Pod 허용 비율 = maxSurge값
    - ex) replicas: 10, maxSurge: 30%
        - 새로운 버전의 Pod을 replicas 수의 최대 30%까지 즉시 Scale Up 할 수 있다.
        - 새로운 버전의 Pod을 3개까지 즉시 생성할 수 있다.
        - 새로운 버전의 Pod 생성과 이전 버전의 Pod 종료를 진행하면서 총 Pod의 수가 replicas수의 130%를 넘지 않도록 유지해야 한다.

### Deployment 롤백
Deployment는 롤아웃 히스토리를 Revision # 으로 관리한다.
롤백 명령어
```
$ kubectl rollout undo deployment <deployment-name> --to-revision=<version>
