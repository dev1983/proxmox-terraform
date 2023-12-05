# Proxmox Full-Clone
# ---
# Create a new VM from a clone

# enter the the name of the new device
resource "proxmox_vm_qemu" "kubemaster" {

    # VM General Settings

    # which proxmox server should this be launched on?
    target_node = "proxserver"
    # make sure this ID is unqiue.  If you reuse ID's you will get errors :)
    vmid = "114"
    # name of the new device again
    name = "kubemaster"
    desc = "Description"

    # VM Advanced General Settings
    onboot = true
    # VM OS Settings
    clone = "vm-template-u22.04"

    # make sure to install qemu-guest-agent on image cloning
    # otherwise terafform will hang creating the vm
    agent = 1

    # VM CPU Settings
    # set cpu cores
    cores = 4
    sockets = 1
    cpu = "host"

    # VM Memory Settings
    # how much ram?
    memory = 4096

    # how big for the disk image?
    disk {
        storage = "local-lvm"
        type = "virtio"
        size = "100G"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # set to your network
    # ipconfig0 = "ip=192.168.1.7/24,gw=192.168.1.1"

    # (Optional) Default User
    ciuser = "ubuntu"

    # (Optional) Add your SSH KEY
    sshkeys = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1gGncamKtT7UhYNiH25fJ4ocjVrN+14KfVojvR7Fg3  
    EOF
}
