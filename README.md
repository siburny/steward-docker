# steward-docker

Script to create a docker image for Steward. For all scripts are in Windows Powershell script. You can run the scripts like 'Powershell.exe -File <script-name>' or through Powershell interface.

Built image is using [this fork](https://github.com/siburny/steward): it's missing a lot of legacy plugings. Out of the box, you should see 2 devices: clock and "tick/tock".

### Building
.\build.ps1

### Executing
`.\start.ps1` to start
`.\stop.ps1` to stop
`.\restart.ps1` to restart
