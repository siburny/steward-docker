#set default TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Clear stale artifacts
try { rm -force -r steward-master -erroraction stop } Catch { }
try { rm master.zip -erroraction stop } Catch { }

# Download archive
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://github.com/siburny/steward/archive/master.zip","master.zip")

# Extract archive
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("master.zip", ".\")

# Build image
docker build -t siburny/steward .

# Clear stale artifacts
try { rm -force -r steward-master -erroraction stop } Catch { }
try { rm master.zip -erroraction stop } Catch { }
