# DESCRIPTION

Every application in Unifi DreamMachine got stuck at starting loop after a powerloss.

I tried to unplug UDM from power --> wait for a minute -> plug power back --> no success.

There were no suffecient information on forums how to fix the issue.

I decided to do a factory reset but first I needed to get backups to the local machine. Bellow you can find commands for copying files through SSH.

>### EDIT: \
>Downloading backups through SSH was great excercise but in the end it didn't matter. At the time I didn't know that my backups go to cloud also which I ended using for restore point.
>
>### TODO:\
>Local automated backup solution.

>>### EDIT 2: \
>>Possible cause: \
>>Internal storage was full. Before factory reset internal storage was 12.xGB / 13.1GB \
>>After restore internal storage usage was  980 MB / 13.1GB
>>
>>After simple google search "UDM pro internal storage full" gave couple of results with similar issues
>>
>>My Installation contained atleast 8 months of deep packet inspection data. Also I guess there were a loads of log entries (errors) in logs since this issue was ongoing for over a week.



# Network application
You can find backup location through SSH
- /data/unifi/data/backup/
- /data/unifi/data/backup/autobackup

I decided to download three latest backups

I used SCP in windows terminal to download files.

First I defined variable which contains username & IP. Example:
```powershell
$udm = 'username@ipadress:'
```

## Autobackup folder

### 2022 03 26 - 7.0.23

```powershell
scp "$udm/data/unifi/data/backup/autobackup/autobackup_7.0.23_20220326_0100_1648256400025.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```
### 2022 04 9 - 7.0.25
```powershell
scp "$udm/data/unifi/data/backup/autobackup/autobackup_7.0.25_20220409_0100_1649466000040.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```

### 2022 04 16 - 7.0.25
```powershell
scp "$udm/data/unifi/data/backup/autobackup/autobackup_7.0.25_20220416_0100_1650070800036.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```

## backup folder (from upgrading the system)

### 2022 03 29 - 6.5.55.unf
```powershell
scp "$udm/data/unifi/data/backup/6.5.55.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```

### 2022 03 29 - 7.0.22.unf
```powershell
scp "$udm/data/unifi/data/backup/7.0.22.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```

### 2022 03 29 - 7.0.23.unf
```powershell
scp "$udm/data/unifi/data/backup/7.0.23.unf" 'F:\Backups\20220424 UDM EMERGENCY\'
```


# System restore

1. Log in to UDM. Settings --> Advanced --> Console Controls --> Factory Reset

2. After couple of minutes browse to 192.168.1.1

3. Log in with ui.com account and select backup you want to restore

4. Wait for a while --> done

5. Logged back to UDM --> Settings --> Updates --> Stopped Talk and Access Applications 

6. Checked network application was working --> updated network to latest version

7. Checked protect was working --> updated protect to latest version

