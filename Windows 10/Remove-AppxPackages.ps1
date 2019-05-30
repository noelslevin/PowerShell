$allowedapps = "Microsoft.BingWeather", "Microsoft.Windows.Photos", "Microsoft.WindowsAlarms", "Microsoft.WindowsCalculator", "Microsoft.WindowsCamera", "Microsoft.WindowsMaps", "Microsoft.WindowsSoundRecorder", "Microsoft.WindowsStore", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo"
$apps = Get-AppxProvisionedPackage -Online
foreach ($app in $apps) {
	if (-not($allowedapps.Contains($app.DisplayName))) {
		Remove-AppxProvisionedPackage -Online -PackageName $($app.PackageName)
	}
}