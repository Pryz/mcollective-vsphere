metadata     :name        => "vSphere Agent",
             :description => "Virtual machine management for vSphere hypervisor",
             :author      => "Julien Fabre",
             :license     => "",
             :version     => "0.1",
             :url         => "",
             :timeout     => 120

action "start_vm", :description => "Start provided Virtual Machine" do
    display :always

    input :vm_name,
          :prompt      => "VM name",
          :description => "Virtual Machine name",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37
    
    input :dc_name,
          :prompt      => "DC name",
          :description => "Datacenter where the VM is living",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37

   output :status,
          :description => 'Status of VM action',
          :display_as  => "Status"
end

action "reset_vm", :description => "Reset provided Virtual Machine" do
    display :always

    input :vm_name,
          :prompt      => "VM name",
          :description => "Virtual Machine name",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37
    
    input :dc_name,
          :prompt      => "DC name",
          :description => "Datacenter where the VM is living",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37

   output :status,
          :description => 'Status of VM action',
          :display_as  => "Status"
end

action "stop_vm", :description => "Stop provided Virtual Machine" do
    display :always

    input :vm_name,
          :prompt      => "VM name",
          :description => "Virtual Machine name",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37
    
    input :dc_name,
          :prompt      => "DC name",
          :description => "Datacenter where the VM is living",
          :validation  => '^[a-zA-Z\-_\d]+$',
          :type        => :string,
          :optional    => false,
          :maxlength   => 37

   output :status,
          :description => 'Status of VM action',
          :display_as  => "Status"
end
