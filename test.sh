imageSourcePath="/Users/Eoleedi/Documents/GitHub/generative_inpainting/data/ourimage/original/"
imagePreparedPath="/Users/Eoleedi/Documents/GitHub/generative_inpainting/data/ourimage/prepared/"
imageOutputPath="/Users/Eoleedi/Documents/GitHub/generative_inpainting/data/ourimage/result/"
checkpoint_dir="/Users/Eoleedi/generative_inpainting/model_logs/guided_celeba_canny_best/"

while getopts f: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;
    esac
done
if [[ "${filename}" == "" ]]; then
    echo "Usage: ./test.sh -f <filename>"
    exit 1
fi
extension="${filename##*.}"
filename="${filename%.*}"
python utils/guided_data_prepare.py --image "${imageSourcePath}${filename}.${extension}" --output "${imagePreparedPath}"
python test.py --image "${imagePreparedPath}${filename}_input.jpg" --mask "${imagePreparedPath}${filename}_mask.jpg" --guidance "${imagePreparedPath}${filename}_edge.jpg" --output "${imageOutputPath}${filename}_out.jpg" --checkpoint_dir $checkpoint_dir