$getCurrentPath = (Get-Item -Path '.\' -Verbose).FullName
$slash = "\"
$outputFolderName = "output" 
$format = '.mp4'
$videoResolutions = '137/399/136/398/135/397/134'
$audioBitrate = '251/140/250'

while($true){
write-host "------------------------------------------------------------------------------"
write-host "Slim and trim YT downloader ( v1.0 beta) [Mr.Cat] " 
write-host "------------------------------------------------------------------------------"
$url = Read-Host 'Enter YouTube URL'
$startTime= Read-Host 'Start time [Minutes:Seconds]'
$timeSplit = $startTime.Split(":")
$fname = youtube-dl -e $url
$finalValue = $fname.Split([System.IO.Path]::GetInvalidFileNameChars() -join ' ')
$MinutesToSeconds = new-timespan -minutes $timeSplit[0] -seconds $timeSplit[1]
write-host $MinutesToSeconds
write-host "Processing your request. Please wait"
& ffmpeg -ss $MinutesToSeconds -i $(youtube-dl -f $videoResolutions -g  $url) -acodec copy -vcodec copy -t 30 video.mp4
& ffmpeg -ss $MinutesToSeconds -i $(youtube-dl -f $audioBitrate -g  $url) -t 30 audio.m4a
& ffmpeg -i video.mp4 -i audio.m4a -c:v copy -c:a aac  $getCurrentPath$slash$outputFolderName$slash$finalValue$format
Remove-Item video.mp4
Remove-Item audio.m4a	
write-host "File downloaded ( check output folder )"
}