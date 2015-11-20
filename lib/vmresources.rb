module VMResources
  extend self

  attr_accessor :percent_of_memory_for_vm, :percent_of_cpus_for_vm

  def system_memory_kbytes
    `sysctl hw.memsize`.sub(/^hw.memsize: /,'').to_i
  end

  def system_memory_mb
    system_memory_kbytes / 1024 / 1024
  end

  def ratio_of_memory_for_vm
    percent_of_memory_for_vm.to_f / 100.0
  end

  def min_host_memory_mb
    4 * 1024
  end

  def max_vm_memory_mb
    system_memory_mb - min_host_memory_mb
  end

  def ideal_vm_memory_mb
    (system_memory_mb * ratio_of_memory_for_vm).floor
  end

  def vm_memory(percent_of_host: 80)
    self.percent_of_memory_for_vm = percent_of_host
    @vm_memory ||= [ideal_vm_memory_mb, max_vm_memory_mb].min
  end

  def system_cpu_count
    `sysctl hw.ncpu`.sub(/^hw.ncpu: /,'').to_i
  end

  def ratio_of_cpus_for_vm
    percent_of_cpus_for_vm.to_f / 100.0
  end

  def ideal_vm_cpus
    (system_cpu_count * ratio_of_cpus_for_vm).floor
  end

  def min_vm_cpus
    1
  end

  def vm_cpu_count(percent_of_host: 80)
    self.percent_of_cpus_for_vm = percent_of_host
    @vm_cpu_count ||= [ideal_vm_cpus, min_vm_cpus].max
  end

  def home_dir
    File.expand_path('~')
  end

  def ssh_private_key_files
    @ssh_private_key_files ||= begin
      ssh_dir = File.join(home_dir, '.ssh')
      rsa_path = File.join(ssh_dir, 'id_rsa')
      dsa_path = File.join(ssh_dir, 'id_dsa')
      vagrant_path = File.join(home_dir, '.vagrant.d',
                               'insecure_private_key')
      [ENV['VAGRANT_SSH_PRIVATE_KEY_PATH'].to_s,
       rsa_path,
       dsa_path,
       vagrant_path].select { |f| File.exist?(f) }
    end
  end
end
