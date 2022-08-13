cd `dirname $0`
DIR=`pwd`
cd ../BCDice
HASH=`git rev-parse HEAD`
#bundle install
#bundle exec rake

cd $DIR
ruby create.rb $HASH > bcdice.json