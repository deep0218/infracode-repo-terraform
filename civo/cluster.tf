resource "civo-firewall" "my-firewall" {
    name = "my-firewall"
}


resource "civo_kubernetes_cluster" "cluster" {
    firewall_id = civo_firewall.my-firewall.id 
    name = var.cluster_name
    applications = ""
    num_target_nodes = var.cluster_nodes
    target_nodes_size = element(data.civo_instances_size.large.sizes, 0).name
}

data "civo_kubernetes_cluster" "cluster" {
    name = civo_kubernetes_cluster.cluster.name
}

data "civo_instances_size" "large" {
    filter {
        key = "cpu_cores"
        values = ["4"]
    }
}
