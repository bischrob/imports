FROM neo4j:4.3.6-enterprise

LABEL description="This is the docker container to run SocioMap"

ENV NEO4J_ACCEPT_LICENSE_AGREEMENT=yes
ENV NEO4J_dbms_ssl_policy_bolt_client__auth=NONE
ENV NEO4J_dbms_ssl_policy_https_client__auth=NONE
ENV NEO4J_dbms_security_procedures_unrestricted=apoc.*
ENV NEO4J_dbms_security_procedures_allowlist=apoc.*
ENV NEO4J_apoc_import_file_enabled=true
ENV NEO4J_apoc_export_file_enabled=true
ENV NEO4J_AUTH=none
ENV NEO4J_dbms_memory_heap_initial__size=2g
ENV NEO4J_dbms_memory_heap_max__size=8g
ENV NEO$J_dbms_memory_pagecache_size=2g
ENV NEO4J_apoc_import_file_enabled=true
ENV NEO4J_dbms_security_allow__csv__import__from__file__urls=true
ENV NEO4JLABS_PLUGINS=[\"apoc\"]

EXPOSE 7474 7687

COPY sociomap.dump /var/lib/neo4j/import/sociomap.dump

