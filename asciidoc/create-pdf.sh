#!/usr/bin/env bash

# Creates a PDF using asciidoctor-pdf

function create_pdf_from_file() {
    local SRC_FILE=$1
    local OUT_DIR=$2

    echo "Creating PDF from '${SRC_FILE}'..."
    asciidoctor-pdf -D "${OUT_DIR}" "${SRC_FILE}" | exit 1;
}


function create_pdf_from_index() {
    local SRC_DIR=$1
    local OUT_DIR=$2

    create_pdf_from_file "${SRC_DIR}/index.adoc" "${OUT_DIR}"
}

function create_readme () {
    local OUT_DIR=$1
    echo "Creating README..."
    printf "Created: $(date +%Y-%m-%d" "%H:%M:%S" "%Z)\n\n" > "${OUT_DIR}/README.txt"
    printf "All files in this directory are auto-created and will be overwritten next conversion.\nDo not edit anything in these directories.\n" >> "${OUT_DIR}/README.txt"
}

function wipe_output_dir() {
    local OUT_DIR=$1
    if [ -d "${OUT_DIR}" ]; then
        echo "Cleaning output dir: '${OUT_DIR}'..."
        pushd "${OUT_DIR}"
        #Using find to be more gentle than rm -r
        find . -type f -delete || exit 1;
        find . -type d -delete || exit 1;
        popd
        echo "Output dir cleaned successfully!"
    fi
}

function create_individual_file_pdfs() {
    local SRC_DIR=$1
    local OUT_DIR=$2

    for file in "${SRC_DIR}"/* "${SRC_DIR}"/**/* ; do

        echo "Found file: '${file}'"

        if [[ $file =~ .*\.adoc$ ]]; then # TODO this regexp is not perfect but might be good enough...
            create_pdf_from_file "${file}" "${OUT_DIR}"
        fi

    done;
}

#################################################

pushd "${BASH_SOURCE%/*}/"
echo "Converting asciidoc to PDF..."

INPUT_DIR="${INPUT_DIR:-.}"
OUTPUT_DIR="generated-pdfs"
mkdir -p "${OUTPUT_DIR}" || exit 1
wipe_output_dir "${OUTPUT_DIR}"
create_readme "${OUTPUT_DIR}"


#if [ "${INPUT_DIR}" = "." ]
#then
    # This is not a file specific generation
#    create_pdf_from_index "${INPUT_DIR}" "${OUTPUT_DIR}"
#fi

create_individual_file_pdfs "${INPUT_DIR}" "${OUTPUT_DIR}"

popd

echo "Converted files successfully"
