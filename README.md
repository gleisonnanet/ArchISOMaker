# ArchISOMaker
Um criador de ISO do Arch Linux personalizado (apenas um monte de scripts)

## Instruções

* Clonar este repositório.
* Execute `$ sudo ./build.sh -v`
* ???
* Lucro! Seu arquivo ISO estará no pai desta pasta.

## Introdução

Esta é uma coleção de scripts baseada no Archiso, que permite que você construa seu
próprio Arch Linux ISO. A principal diferença do upstream é que esta variante
puxa os pacotes ArchLinux mais atualizados e os incorpora no arquivo ISO.
Isso significa que você não precisa mais ter uma conexão com a Internet quando
*instalando* o Arch Linux a partir deste ISO.

Além disso, um script de instalação personalizado também é incorporado ao ISO, para que você
pode instalar uma versão *padrão* do Arch Linux de forma não interativa. Claro, você
não são forçados a usá-lo, se você deseja instalar manualmente o Arch Linux seguindo as
instruções wiki.

## Construindo sua ISO

Você precisa ter o `archiso` instalado em seu sistema para usar este script, e um
uma conexão de internet funcionando para puxar os pacotes que vamos incorporar no ISO.
Os pacotes embutidos são especificados em `airootfs/root/packages.sh`, serão
baixado em `airootfs/root/pkg`, e será atualizado automaticamente quando
você executa `build.sh` (o script de construção ISO).

Se você não quiser atualizar automaticamente os pacotes ao executar o script,
edite `customtools.sh` e altere a variável *UPDATECACHE* para 0.

## Testando sua ISO

O ISO gerado vem com drivers do virtualbox, para que você possa configurar um VirtualBox
machine e execute seu ISO lá.

Alternativamente, `archiso` fornece um método conveniente que usa QEMU:

- `run_archiso -i path/to/an/arch.iso` para executar como BIOS
- `run_archiso -u -i path/to/an/arch.iso` para executar como UEFI

## Instalando seu sistema

Grave o ISO gerado em um DVD ou pendrive.
Ao inicializá-lo, você será saudado por uma mensagem de boas-vindas que indica o
passos necessários que você deve seguir, para que você possa executar a instalação
script (`install.sh`).

### Informação relevante

O script de instalação (`install.sh`) usa as configurações do arquivo `env.sh`,
então você é obrigado a editá-lo *antes* de instalar o sistema!

### Descrições do script

Cada arquivo de script desempenha uma função específica:

- `install.sh`: O script de instalação principal.
- `env.sh`: O script de ambiente que armazena as informações de instalação/configuração.
- `config.sh`: Um script de configuração que dentro do *chroot*, após instalar o
pacotes. Ele usa as informações armazenadas em `env.sh`.
- `packages.sh`: Um "banco de dados" de pacotes necessários dependendo de suas escolhas em
o script de instalação.
- `printer.sh`: Um script de impressora, usado principalmente para imprimir mensagens coloridas.

## Pacotes disponíveis por padrão

### Ambientes de trabalho
* KDE (Plasma)
* GNOME (GNOME Shell)
* i3 (Gerenciador de janelas)
* X11 (Xorg mínimo)

### Carregadores de inicialização
* rEFInd
* GRUB

### Drivers gráficos
* nVidia
* AMD
*Virtual Box
* Intel
