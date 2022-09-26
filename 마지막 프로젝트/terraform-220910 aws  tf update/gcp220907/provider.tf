provider "google" {
  credentials = file("credentials.json")
  project = "bmo-project-361100"
  region = "asia-northeast3"
}
