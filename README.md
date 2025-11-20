# womic-linux
🇬🇧 Bash script for running WO Mic on Linux and connect it with your phone

///

🇪🇸 Script de Bash para el uso de WO Mic en Linux y conectarlo con tu teléfono

---

### 🇬🇧 English
<details>
  <summary>Click to expand</summary>

## Purpose
The purpose of this script is to be able to connect to a locally started WO Mic server in the background and exit the terminal freely, without having to remember the PID, when you want to disconnect.

## Notes
The WO Mic Appimage binary has to be downloaded in order for the script to work. 

That can be done either automatically or manually. 

If you prefer to download it yourself, you can do so according to the instructions from the [official site](https://wolicheng.com/womic/wo_mic_linux.html) (step 1) and then you will need to move the AppImage file to the same directory as the script.

## Usage

Place the script in the same folder as the extracted AppImage binary and run it like so:

```
$ ./womic.sh [OPTION]
```

OPTIONS:

`-b` - to connect via Bluetooth\
`-w` - to connect via WiFi\
`-k` - to disconnect\
`-h` - to show this help message\
`-u` - to show the user manual

</details>

---

### 🇪🇸 Español
<details>
  <summary>Haz clic para expandir</summary>

## Propósito
El propósito de este script es poder conectarse al servicio de WO Mic local, que se ejecuta en segundo plano, para dejar la terminal libre, y sin necesidad de recordar el PID cuando quieras desconectarte.

## Notas
Primero se debe descargar la AppImage de WO Mic para poder usar el script.
Se puede hacer de forma manual o automática.

Si prefieres descargarlo por ti mismo, puedes hacerlo desde la web clickeando [aquí](https://wolicheng.com/womic/wo_mic_linux.html).
Luego de descargarlo, mueve el archivo AppImage al mismo directorio donde se encuentra el script.

## Cómo usarlo

Guarda el script en el mismo directorio que el AppImage de WO Mic y luego ejecuta el script así:
```
$ ./womic.sh [OPCION]
```

POSIBLES OPCIONES:

`-b` - para conectarse vía Bluetooth\
`-w` - para conectarse vía WiFi\
`-k` - para desconectarse\
`-h` - para mostrar este mismo mensaje de ayuda\
`-u` - para mostrar el manual de usuario


</details>
