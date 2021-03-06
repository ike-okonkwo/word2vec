DATA_DIR=../data
BIN_DIR=../bin

TEXT_DATA=$DATA_DIR/text8
VECTOR_DATA=$DATA_DIR/text8-vector.bin

TEXT_DATA=$DATA_DIR/fashion_blogs.txt
VECTOR_DATA=$DATA_DIR/fashion_blogs.bin

pushd ${BIN_DIR} && make; popd

if [ ! -e $VECTOR_DATA ]; then

  if [ ! -e $TEXT_DATA ]; then
    wget http://mattmahoney.net/dc/text8.zip -O $DATA_DIR/text8.gz
    gzip -d $DATA_DIR/text8.gz -f
  fi
  echo -----------------------------------------------------------------------------------------------------
  echo -- Training vectors...
  time $BIN_DIR/word2vec -train $TEXT_DATA -output $VECTOR_DATA -cbow 0 -size 200 -window 5 -negative 0 -hs 1 -sample 1e-3 -threads 12 -binary 1

fi

echo -----------------------------------------------------------------------------------------------------
echo -- distance...

$BIN_DIR/distance $DATA_DIR/$VECTOR_DATA
