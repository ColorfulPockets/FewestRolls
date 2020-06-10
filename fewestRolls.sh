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

	IFS=$'\n' sorted=($(sort <<<"${moveSet[*]}"))
	unset IFS
	printf "\n%d: " $setNumber
	let setNumber=setNumber+1
	printf "%s " "${sorted[@]}"
	printf ": "
	read
	input=($REPLY)

	if [ ${#input[@]} -ne 0 ]; then
		end=${input[${#input[@]}-1]}
		if [[ $end = "free" ]]; then
			echo "2 moves allotted. Solve position not incremented."
			let moveCount=moveCount-1
			let setNumber=setNumber+1
		else
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
		fi
	else
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
	fi

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

