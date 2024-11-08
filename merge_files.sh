file1=$(zenity --file-selection --title="Select file1.pdf" --file-filter="*.pdf")

echo "file1 added"
# If file1 is not selected, exit
if [ -z "$file1" ]; then
  zenity --error --text="No file selected. Exiting..."
  exit 1
fi

# Ask the user to select file2.pdf
file2=$(zenity --file-selection --title="Select file2.pdf" --file-filter="*.pdf")
echo "file 2 added"

# If file2 is not selected, exit
if [ -z "$file2" ]; then
  zenity --error --text="No file selected. Exiting..."
  exit 1
fi
echo "converting files"
pdftotext -layout "$file1" "${file1%.pdf}.txt"
echo "file1 converted"

pdftotext -layout "$file2" "${file2%.pdf}.txt"

echo "file 2 converted"
cp "${file2%.pdf}.txt" /home/nikhil/
echo "copied '${file2%.pdf}.txt'"
echo "selecting the couloumns"
awk '$1 >=1 && $1 <= 11' "${file1%.pdf}.txt" | awk '{print $(NF - 9)","$(NF-3)","$(NF-1),$NF}' >> file3.txt
echo "file3"
awk '$1 >=1 && $1 <= 11' "${file2%.pdf}.txt" | awk '{print $(NF - 9)","$(NF-3)","$(NF-1),$NF}' >> file4.txt
echo "file4"
paste file3.txt file4.txt >> file5.txt
echo "completed"


