Usage
-----

## 1. Install Vagrant
※ Do this step if you haven't done it in your system yet
* https://www.vagrantup.com/downloads.html
{VAGRANT_CHEF}
## 2. Add vagrant box
※ Do this test if you haven't used {VAGRANT_BOX_NAME} box in your system yet
* Run command
    ```
    $ vagrant box add {VAGRANT_BOX_NAME} '{VAGRANT_BOX_URL}'
    ```

## 3. Start vagrant
* Run command
    ```
    $ vagrant up
    ```

## 4. Configure hosts file
* Add host name to your `/etc/hosts` (C:\Windows\System32\drivers\etc\hosts on Windows)
    ```
    {VAGRANT_GUESS_IP} {VAGRANT_LOCAL_DOMAIN}
    ```
