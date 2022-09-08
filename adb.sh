x=500
y=750

cmd='adb shell input'
S='sleep 1'
function loop(){
	$S; $cmd tap 187 2305
	$S; $cmd tap 286 1907
	$S; $cmd tap 286 1933
	$S; $cmd tap 91 167
	sleep 2
}
	
for i in $(seq 1 20);do
	adb shell input tap $x $y
	let y+=250

	loop


	if [[ $y -eq 2000 ]];then
		$cmd swipe $x $y $x 750 2000
		y=750
	fi
done
