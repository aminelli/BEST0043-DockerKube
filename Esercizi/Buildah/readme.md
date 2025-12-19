Ti aiuto a creare un'immagine container con Buildah che include Debian, Tomcat 9 e Java 21.

```sh
#!/bin/bash

# Crea un nuovo container da Debian
container=$(buildah from debian:12)

# Aggiorna il sistema e installa dipendenze
buildah run $container -- apt-get update
buildah run $container -- apt-get install -y wget curl gnupg2 ca-certificates

# Installa Java 21 (OpenJDK)
buildah run $container -- apt-get install -y openjdk-21-jdk

# Configura variabili d'ambiente per Java
buildah config --env JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64 $container
buildah config --env PATH=/usr/lib/jvm/java-21-openjdk-amd64/bin:$PATH $container

# Scarica e installa Tomcat 9
buildah run $container -- wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz -O /tmp/tomcat.tar.gz
buildah run $container -- mkdir -p /opt/tomcat
buildah run $container -- tar xzvf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1
buildah run $container -- rm /tmp/tomcat.tar.gz

# Configura variabili d'ambiente per Tomcat
buildah config --env CATALINA_HOME=/opt/tomcat $container
buildah config --env PATH=/opt/tomcat/bin:$PATH $container

# Espone la porta 8080
buildah config --port 8080 $container

# Imposta la directory di lavoro
buildah config --workingdir /opt/tomcat $container

# Comando di avvio
buildah config --cmd '/opt/tomcat/bin/catalina.sh run' $container

# Pulizia
buildah run $container -- apt-get clean
buildah run $container -- rm -rf /var/lib/apt/lists/*

# Crea l'immagine finale
buildah commit $container tomcat9-java21:latest

# Rimuovi il container temporaneo
buildah rm $container

echo "Immagine creata con successo: tomcat9-java21:latest"
echo "Per avviarla usa: podman run -d -p 8080:8080 tomcat9-java21:latest"
```



Ho creato uno script Buildah che genera un'immagine container con:


- **Debian 12** come sistema operativo base
- **OpenJDK 21** 
- **Apache Tomcat 9.0.96**

**Come usare lo script:**

1. Salva lo script in un file (es. `build-tomcat.sh`)
2. Rendi lo script eseguibile:
   ```bash
   chmod +x build-tomcat.sh
   ```
3. Esegui lo script:
   ```bash
   sudo ./build-tomcat.sh
   ```

**Per avviare il container:**
```bash
podman run -d -p 8080:8080 tomcat9-java21:latest
```

Tomcat sarà accessibile all'indirizzo `http://localhost:8080`

**Personalizzazioni possibili:**
- Cambia la versione di Tomcat modificando l'URL del download
- Aggiungi applicazioni WAR copiandole in `/opt/tomcat/webapps/`
- Modifica le configurazioni di Tomcat in `/opt/tomcat/conf/`

Vuoi che aggiunga qualcosa di specifico all'immagine, come configurazioni particolari o applicazioni da deployare?