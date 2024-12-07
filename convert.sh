#! /bin/bash
function connect {
    for CoI;do
            echo -n "$CoI"
    done
}
{
        read
        echo -n '{'
        tm=0
        echo -n 'Converting: ' >&2
        while read -r line;do
                [ "${line:0:1}" == '}' ] && break
                ps="$(expr index "${line:1}" '"')"
                c=() cnt=0 fstc=1
                for((i=ps;i<=${#line};++i));do
                        [ "${line:$i:1}" == '%' ] && {
                            c[${#c[@]}]="$([ "$fstc" == 0 ] && echo -n ',')"'\n\"'"$cnt"'\": %s'
                            cnt="$[cnt+1]"
                            fstc=0
                        }
                done
                pl="${line:0:$ps}"
                vd=''
                [ "${#c[@]}" -gt 0 ] && vd='{'"$(connect "${c[@]}")"'\n}'
                echo -n "$([ "$tm" != 0 ] && echo -n ',')"$'\n'' '"$pl"'": '"$pl$vd"'"'
                [ "$[tm%100]" == 0 ] && echo -n $'\r'$'\e''[12C'$'\e''[K'"$tm" >&2
                tm="$[tm+1]"
        done
	echo -n 'ENDED'$'\e''[K' >&2
        echo $'\n''}'
} < origin.json > result.json
