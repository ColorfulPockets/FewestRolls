#! /bin/bash

moves=( 'R' 'L' 'U' 'D' 'B' 'F' )
isDone=0
setNumber=1
moves=0
printf "Scramble: "
read
while [ $isDone -ne 1 ]; do
	count=0
	moveSet=()
	echo -n ""
	until [ $count -gt 11 ]; do
		index=$[$RANDOM % ${#moves[@]}]
		moveType=${moves[${index}]}
		moveSet+=($moveType)
		let count=count+1
	done
	IFS=$'\n' sorted=($(sort <<<"${moveSet[*]}"))
	unset IFS
	printf "\n%d: " $setNumber
	let setNumber=setNumber+1
	printf "%s " "${sorted[@]}"
	printf ": "
	read
	input=($REPLY)
	let moves=moves+${#input[@]}
	if [ -n ${REPLY[1]} ]; then
		if [[ $REPLY = "DONE" ]]; then
			isDone=1
		fi
		if [[ $REPLY = "done" ]]; then
			isDone=1
		fi
		if [[ $REPLY = "Done" ]]; then
			isDone=1
		fi
	fi
done

let setNumber=setNumber-2
let moves=moves-1
printf "\nScore: %d\tMoves: %d\n" $setNumber $moves

