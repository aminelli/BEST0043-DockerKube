
```Dockerfile
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

```

Perfetto! Ho convertito lo script in un Dockerfile. Ecco come usarlo con Buildah:

**Per costruire l'immagine con Buildah:**

```bash
# Build usando il Dockerfile
buildah bud -t tomcat9-java21:latest -f Dockerfile .

# Oppure con il comando completo
buildah build-using-dockerfile -t tomcat9-java21:latest -f Dockerfile .
```

**Per avviare il container:**

```bash
# Con Podman
podman run -d -p 8080:8080 tomcat9-java21:latest

# Oppure con Buildah + Podman
buildah push tomcat9-java21:latest containers-storage:localhost/tomcat9-java21:latest
podman run -d -p 8080:8080 localhost/tomcat9-java21:latest
```

**Vantaggi del Dockerfile:**
- Più portabile e standard rispetto allo script Buildah
- Può essere usato anche con Docker se necessario
- Più facile da versionare e manutenere
- Sintassi più conosciuta e documentata

**Comandi utili:**

```bash
# Lista le immagini create
buildah images

# Ispeziona l'immagine
buildah inspect tomcat9-java21:latest

# Esporta l'immagine
buildah push tomcat9-java21:latest docker-archive:tomcat9-java21.tar
```

Vuoi che aggiunga qualcosa al Dockerfile, come la configurazione di utenti non-root o volumi per le applicazioni?