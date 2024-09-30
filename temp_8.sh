#!usr/bin/env bash

while [ true ]
do
    echo "Enter 1-Autograde all the students"
    echo "Enter 2-Autograde based on the roll number"
    echo "Enter 3-Exit"
    echo "Enter option number to execute above options:"
    read option
    if [ $option -eq 1 ]
    then
        l=8
        while [ $l -gt 0 ]
        do
            root_directory="./students"
            student_details="student_details.txt"
            rollno=$(gawk '{ print $1 }' ./student_details.txt | head -$l | tail -1)
            temp_file=$(mktemp)
    

            for dir in $(find "$root_directory" -mindepth 1 -maxdepth 1 -type d)
             do
                dir_name=$(basename "$dir")
                if [ "$dir_name" == "$rollno" ]
                 then

                    for script in $(find "$dir" -type f -name "*.sh")
                    do
                        folder_path=$(dirname "$script")
                        
                        folder_name=$(basename "$folder_path")
                        
                        if [[ ! " ${folder_names[*]} " =~ " ${folder_name} " ]]
                        then
                            folder_names+=("$folder_name")
                        fi

                        bash "$script" >> "$temp_file" 2>&1
                        reference_file="./expected.txt"
                        compare_file="$temp_file"

                        sorted_reference_file=$(mktemp)
                        sorted_compare_file=$(mktemp)

                        sort "$reference_file" -o "$sorted_reference_file"
                        sort "$compare_file" -o "$sorted_compare_file"
                        
                        
                        

                        different_lines=$(comm -13 "$sorted_reference_file" "$sorted_compare_file" | wc -l)



                        rm "$sorted_reference_file "$sorted_compare_file"
                        echo "$student_name has earned a score of $Marks / 50"
                         

                        rm "$temp_file"

                    if [ $folder_name -eq "$rollno" ]
                    then
                        name=$(awk -v search="$rollno" '$1 == search {print $2}' "$student_details")
                        student_name="$name"
                    fi


                    Marks=$(( 50 - ((different_lines * 5))))
                    echo "$student_name"
                    echo "$student_name has earned a score of $Marks / 50"
                    done
                fi
    
            done
            l=$((l-1))
        done

    elif [ $option -eq 2 ]
    then
    root_directory="./students"
    student_details="./student_details.txt" 
    echo "Enter roll number"
    read rollno
    temp_file=$(mktemp)

    folder_names=()

    for dir in $(find "$root_directory" -mindepth 1 -maxdepth 1 -type d); do
        dir_name=$(basename "$dir")
        if [ "$dir_name" == "$rollno" ]; then

            for script in $(find "$dir" -type f -name "*.sh"); do
                folder_path=$(dirname "$script")
                
                folder_name=$(basename "$folder_path")
                
                if [[ ! " ${folder_names[*]} " =~ " ${folder_name} " ]]; then
                    folder_names+=("$folder_name")
                fi

                bash "$script" >> "$temp_file" 2>&1
                reference_file="./expected.txt"
                compare_file="$temp_file"

                sorted_reference_file=$(mktemp)
                sorted_compare_file=$(mktemp)

                sort "$reference_file" -o "$sorted_reference_file"
                sort "$compare_file" -o "$sorted_compare_file"

                different_lines=$(comm -13 "$sorted_reference_file" "$sorted_compare_file" | wc -l)



                rm "$sorted_reference_file" "$sorted_compare_file"

                rm "$temp_file"

            if [ $folder_name -eq "$rollno" ]
            then
                name=$(awk -v search="$rollno" '$1 == search {print $2}' "$student_details")
                student_name="$name"
            fi


            Marks=$(( 50 - ((different_lines * 5))))
            echo "$student_name"
            echo "$student_name has earned a score of $Marks / 50"


            done
    fi
#done

done
    else
    exit
    fi
done
