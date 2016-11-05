systems({
  base: {
    image   : { docker: 'azukiapp/ruby:2.3' },
    shell   : '/bin/bash',
    wait    : false,
    scalable: false,
  },
  api: {
    extends: 'base',
    depends: ['postgres'],
    provision: [
      "bundle install --path /azk/bundler"
    ],
    workdir: "/azk/#{manifest.dir}/#{system.name}",
    command: "bundle exec notgun -s puma --port 5000 --host 0.0.0.0 config.ru",
    mounts: {
      '/azk/#{manifest.dir}/#{system.name}': path("./#{system.name}"),
      '/azk/bundler': persistent("./#{system.name}/bundler")
    },
    scalable: { default: 1 },
    http: { domains: ["#{system.name}.#{azk.default_domain}"] },
    envs: {
      RACK_ENV: "development",
      MOUSTACHE_URL: "http://#{system.name}.#{azk.default_domain}"
    },
    wait: 15
  },
  admin: {
    extends: 'base',
    depends: ['api'],
    provision: [
      "bundle install --path /azk/bundler"
    ],
    workdir: "/azk/#{manifest.dir}/#{system.name}",
    command: "bundle exec notgun -s puma --port 5000 --host 0.0.0.0 config.ru",
    mounts: {
      '/azk/#{manifest.dir}/#{system.name}': path("./#{system.name}"),
      '/azk/bundler': persistent("./#{system.name}/bundler")
    },
    scalable: { default: 1 },
    http: { domains: ["#{system.name}.#{azk.default_domain}"] },
    envs: {
      RACK_ENV: "development",
      ADMIN_URL: "http://#{system.name}.#{azk.default_domain}"
    },
    wait: 15
  },
  postgres: {
    depends: [],
    image: {"docker": "azukiapp/postgres:9.5"},
    shell: "/bin/bash",
    wait: 20,
    mounts: {
      '/var/lib/postgresql/data': persistent("postgresql"),
      '/var/log/postgresql': path("./log/postgresql"),
    },
    ports: {
      data: "5432/tcp",
    },
    envs: {
      POSTGRESQL_USER: "azk",
      POSTGRESQL_PASS: "azk",
      POSTGRESQL_DB: "postgres_development",
    },
    export_envs: {
      POSTGRESQL_HOST: "#{net.host}",
      POSTGRESQL_PORT: "#{net.port.data}"
    },
  }
});
