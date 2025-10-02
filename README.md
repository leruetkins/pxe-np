
# PXE-NP - GODLIKE PXE SERVER!  

## What is PXE-NP:
**PXE-NP** is a PXE boot server that allows you to launch operating systems and useful programs over the network using [PXE](https://en.wikipedia.org/wiki/Preboot_Execution_Environment) technology. In this case, the iPXE bootloader is used. It works on both BIOS and UEFI systems, with only minor differences in the menu.

The program works on Windows and Linux. The configuration file contains sample settings. The necessary operating system and disk images need to be downloaded separately or, if already available, extracted to the appropriate folders.  

<img width="480" height="640" alt="изображение" src="https://github.com/user-attachments/assets/86004574-5620-41ad-9a66-ba3c90635fe8" /> <img width="480" height="640" alt="изображение" src="https://github.com/user-attachments/assets/9ef93bec-60c5-4c9d-a93c-2d3ff0c6d3e6" />

## How to use:

### 1.
You need to choose the mode in which **PXE-NP** will operate:  
* **Option 1 - DHCP PROXY MODE:**  
    You can run **PXE-NP** in **DHCP PROXY MODE**. By default, after starting, the server runs in this mode and the program header will display **DHCP PROXY MODE**. If it does not appear, you need to enable this mode in the settings.  

* **Option 2 - Configure your DHCP server:**  
    1. If you have a Linux DHCP server, set:  
        ```
        option space PXE;
        option arch code 93 = unsigned integer 16;
        next-server xxx.xxx.xxx.xxx;
        if option arch = 00:07 {
            filename "boot/efi/bootx64.efi";
        } else {
            filename "boot/bios/undionly.kpxe";
        }
        ```  
    2. If you have a Microsoft DHCP server, in your IP pool under Scope Options, add:  
       ```
       066 Boot Server Host Name "Name or address of the machine running PXE-NP, e.g., 192.168.0.2"
       067 Bootfile Name "/boot/efi/bootx64.efi"
       ```  
       More details can be found [here](https://github.com/leruetkins/tftp-np-light/wiki/%D0%9D%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B0-DHCP%E2%80%90%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80-%D0%BD%D0%B0-Windows-Server-2012)  

    3. If you have a Mikrotik DHCP server with firmware version below 7.0, set only for BIOS or UEFI:  
        <details>
        <summary>Screenshot:</summary>
        <img src="https://github.com/leruetkins/tftp-np-light/assets/15270519/026734c3-4a92-453a-ae2d-2c2d8b046961">
        </details>  

    4. If you have a Mikrotik DHCP server with firmware version above 7.0, set different boot files for BIOS and UEFI according to [this guide](./docs/config_mikrotik.md).  

### 2.
Run `PXE-NP.exe` or `PXE-NP.elf` file.

**For Linux users:** You need to give executable permissions and run as administrator to open the required ports:
```
chmod +x PXE-NP.elf
sudo ./PXE-NP.elf
```

**Note:** You can also run PXE-NP in console mode without a graphical interface by adding the `--console` argument:
```
pxe-np.exe --console
```

**Network ports used by PXE-NP:**
- **Port 69** - TFTP server (UDP)
- **Port 2049** - NFS server (TCP/UDP) 
- **Port 5555** - HTTP server (TCP)
- **Port 111** - RPC bind (TCP) - optional, continues without it if unavailable
- **Port 67** - DHCP server (UDP) - when running in DHCP mode  

### 3.
Boot from another machine via PXE. In BIOS settings, enable network boot and disable `Secure Boot` beforehand.  

### 4.
When prompted `Press secret key to continue...`, press the key combination `CTRL` + `S`.  

### 5.
Enjoy! 🎉

<img width="1399" height="554" alt="изображение" src="https://github.com/user-attachments/assets/f6775e3f-68bc-4b9b-9f3b-34e1ec6ffa69" />


<img width="1121" height="509" alt="изображение" src="https://github.com/user-attachments/assets/4c10bf5f-ef2a-4298-972d-1d043c04f671" />

