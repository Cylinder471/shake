resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.10.0"
  values           = [file("./nginx.yaml")]
}
resource "helm_release" "my_app" {
  name             = "my-app"
  chart            = "./Chart" # путь к локальному чарту
  namespace        = "default"
  create_namespace = false

  depends_on = [helm_release.ingress-nginx]
}
resource "helm_release" "observability" {
  name             = "observability"
  chart            = "./grafana/"
  namespace        = "monitoring"
  create_namespace = true

  values = [file("./grafana/values.yaml")]
}
