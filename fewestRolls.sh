#! /bin/bash

moves=( 'R' 'L' 'U' 'D' 'B' 'F' )
isDone=0
setNumber=1
moveCount=0
pocketSize=7
incrementPocket=0
printf "Scramble: "
read
while [ $isDone -ne 1 ]; do
	count=0
	moveSet=()
	echo -n ""
	until [ $count -gt $pocketSize ]; do
		index=$[$RANDOM % ${#moves[@]}]
		moveType=${moves[${index}]}
		moveSet+=($moveType)
		let count=count+1
	done

	if [ $pocketSize -lt 12 ]; then
		if [ $incrementPocket -eq 0 ]; then
			let incrementPocket=1
		else	
			let incrementPocket=0
			let pocketSize=pocketSize+1
		fi
	else
		let pocketSize=pocketSize+1
	fi

	IFS=$'\n' sorted=($(sort <<<"${moveSet[*]}"))
	unset IFS
	printf "\n%d: " $setNumber
	let setNumber=setNumber+1
	printf "%s " "${sorted[@]}"
	printf ": "
	read
	input=($REPLY)
	let moveCount=moveCount+${#input[@]}
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
let moveCount=moveCount-1
printf "\nScore: %d\tMoves: %d\n" $setNumber $moveCount

