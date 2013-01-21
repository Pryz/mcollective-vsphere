# Agent vSphere for mcollective
#
# work in progress ... use it carrefully
#
# Author : Julien Fabre <ju.pryz AT gmail.com>
#

# /etc/kermit/kermit.cfg properties
#
# [vSphere]
# username=admin
# password=password
# vcenter=vcenter.domain.net
#

require 'inifile'
require 'fileutils'
require 'rubygems'
require 'rbvmomi'

module MCollective
    module Agent
        class Vsphere<RPC::Agent
            metadata :name        => "vSphere Agent",
                     :description => "Virtual machine management for vSphere hypervisor",
                     :author      => "Julien Fabre",
                     :license     => "",
                     :version     => "0.1",
                     :url         => "",
                     :timeout     => 120

        action "start_vm" do
          Log.debug "Executing start_vm Action"
          vim = vsphere_connection()
          vm_name = "#{request[:vm_name]}"
          dc_name = "#{request[:dc_name]}"
          response = execute_task(
            find_vm(vim, dc_name, vm_name).PowerOnVM_Task(
                :host => vm.summary.runtime.host
            )
          )
          reply['status'] = response
        end

        action "reset_vm" do
          Log.debug "Executing start_vm Action"
          vim = vsphere_connection()
          vm_name = "#{request[:vm_name]}"
          dc_name = "#{request[:dc_name]}"
          response = execute_task(
            find_vm(vim, dc_name, vm_name).ResetVM_Task
          )
          reply['status'] = response
        end

        action "stop_vm" do
          Log.debug "Executing start_vm Action"
          vim = vsphere_connection()
          vm_name = "#{request[:vm_name]}"
          dc_name = "#{request[:dc_name]}"
          response = execute_task(
            find_vm(vim, dc_name, vm_name).PowerOffVM_Task
          )
          reply['status'] = response
        end

        private

        def find_vm(vim, dc_name, vm_name)
          dc = get_datacenter(vim, dcname)
          dc.find_vm(vm_name) unless dc.nil?
        end
        
        def get_datacenter(vim, dc_name)
          vim.serviceInstance.find_datacenter(dc_name) or nil
        end

        def execute_task(task)
          begin
            task.wait_for_completion
          rescue => exception
            err_message = exception.message
          end
          err_message = task.info.error.localizedMessage unless task.info.error.nil?
          result = { 'state' => task.info.state, 'error' => err_message }
        end


        def vsphere_connection()
          conffile = '/etc/kermit/kermit.cfg'
          section = 'vSphere'

          user = getkey(conffile, section, 'username')
          pwd = getkey(conffile, section, 'password')
          vcenter = getkey(conffile, section, 'vcenter')
          
          opt = {:host => vcenter, :user => user, :password => pwd, :insecure => true}
          begin
            RbVmomi::VIM.connect opt
          rescue => exception
            Log.debug exception.message
            nil
          end
        end

        def getkey(conffile, section, key)
          ini=IniFile.load(conffile, :comment => '#')
          params = ini[section]
          params[key]
        end

        end
    end
end
