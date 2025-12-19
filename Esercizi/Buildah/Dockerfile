FROM debian:12

# Aggiorna il sistema e installa dipendenze
RUN apt-get update && \
    apt-get install -y wget curl gnupg2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installa Java 21 (OpenJDK)
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configura variabili d'ambiente per Java
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Scarica e installa Tomcat 9
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz -O /tmp/tomcat.tar.gz && \
    mkdir -p /opt/tomcat && \
    tar xzvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

# Configura variabili d'ambiente per Tomcat
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Espone la porta 8080
EXPOSE 8080

# Imposta la directory di lavoro
WORKDIR /opt/tomcat

# Comando di avvio
CMD ["/opt/tomcat/bin/catalina.sh", "run"]