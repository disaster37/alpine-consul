#!/usr/bin/with-contenv sh

cat << EOF > ${CONFD_HOME}/etc/conf.d/config.json.toml
[template]
prefix = "${CONFD_PREFIX_KEY}"
src = "config.json.tmpl"
dest = "${APP_HOME}/conf/config.json"
mode = "0744"
keys = [
  "/config",
]
EOF

cat << EOF > ${CONFD_HOME}/etc/conf.d/run.toml
[template]
prefix = "${CONFD_PREFIX_KEY}"
src = "run.tmpl"
dest = "/etc/services.d/consul/run"
mode = "0744"
keys = [
  "/config",
]
EOF
