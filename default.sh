#type=""
bash -c "if [ -f \"$(home-manager generations | head -1 | awk '{print $7}')/specialisation/$type/activate\" ]; then
   \"$(home-manager generations | head -1 | awk '{print $7}')/specialisation/$type/activate\";
fi"
#type=""
