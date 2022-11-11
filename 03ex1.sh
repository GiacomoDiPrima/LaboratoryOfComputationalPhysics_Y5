cd $HOME

if [ ! -d "students" ]
then
    echo "Directory students doesn't exists."
    mkdir students
    echo "Directory students have been created."
else
    echo "Directory students already exists."
fi

cd students

if [ ! -f "LCP_22-23_students.csv" ]
then
    echo "LCP_22-23_students.csv doesn't exists. Now downloading it"
    wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv &> log.txt
    echo "File is been downloaded"
else 
    echo "File already existing"
fi

if [ ! -f "PoD.txt" ]
then
    echo "Creating PoD.txt"
    touch PoD.txt
else
    echo "PoD.txt already exists"
fi
    


if [ ! -f "Phy.txt" ]
then
    echo "Creating Phy.txt"
    touch Phy.txt
else
    echo "Phy.txt already exists"
fi


grep "PoD" LCP_22-23_students.csv > PoD.txt
grep "Physics" LCP_22-23_students.csv > Phy.txt

maxPOD=0
maxPHY=0
for alpha in {A..Z}
do
    countPOD=$(cut -f1 -d "," PoD.txt | grep -c "$alpha" )
    countPHY=$(cut -f1 -d "," Phy.txt | grep -c "$alpha" )
    echo "$alpha in PoD.txt : $countPOD"
    echo "$alpha in Phy.txt : $countPHY"
    
    if [ $maxPOD -lt $countPOD ]
    then
        maxPOD=$countPOD
        betaPOD=$alpha
    fi
    
    if [ $maxPHY -lt $countPHY ]
    then
        maxPHY=$countPHY
        betaPHY=$alpha
    fi
done

echo "$betaPOD is the most repeated letter in POD.txt : $maxPOD times"
echo "$betaPHY is the most repeated letter in POD.txt : $maxPHY times"


nlines=$(sed -n '$=' LCP_22-23_students.csv)
for i in $(seq 1 1 18)
do 
    name="$i"
    name+="file.txt"
    touch $name
    
    for j in $(seq $i 18 $nlines)
    do
            
        n="$j"
        n+="q"    
        line=$(sed "$n;d" LCP_22-23_students.csv)
        echo "$line" > $name
    done
done

