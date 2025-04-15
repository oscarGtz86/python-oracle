FROM oraclelinux:8

# Instala Python y dependencias
RUN dnf install -y python3 libaio unzip && \
    dnf clean all

# Agrega alias python -> python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Variables de entorno Oracle
ENV ORACLE_HOME=/opt/oracle/instantclient_11_2
ENV LD_LIBRARY_PATH=$ORACLE_HOME
ENV PATH=$ORACLE_HOME:$PATH

# Copia el cliente desde el contexto local
COPY instantclient-basic-linux.x64-11.2.0.4.0.zip /opt/oracle/

# Descomprime e instala cliente
RUN cd /opt/oracle && \
    unzip instantclient-basic-linux.x64-11.2.0.4.0.zip && \
    rm instantclient-basic-linux.x64-11.2.0.4.0.zip && \
    ln -s ${ORACLE_HOME}/libclntsh.so.11.1 ${ORACLE_HOME}/libclntsh.so && \
    ln -s ${ORACLE_HOME}/libocci.so.11.1 ${ORACLE_HOME}/libocci.so

# Instala cx_Oracle usando pip de python3
RUN python3 -m ensurepip && \
    python3 -m pip install --no-cache-dir cx_Oracle

WORKDIR /app
COPY . /app

CMD ["python"]