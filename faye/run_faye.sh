dir=`dirname "$0"`
rackup -s thin -E production "$dir/config.ru"
