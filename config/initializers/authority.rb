Authority.configure do |config|
  config.controller_action_map = {
    index: 'read',
    show: 'read',
    new: 'create',
    create: 'create',
    edit: 'update',
    update: 'update',
    destroy: 'delete',
    download: 'download'
  }

  config.abilities =  {
    create: 'creatable',
    read: 'readable',
    update: 'updatable',
    delete: 'deletable',
    download: 'downloadable'
  }
end
