<?php

require_once 'configuration.php';

$config = new JConfig();

$host = $config->host;
$db   = $config->db;
$user = $config->user;
$pass = $config->password;
$prfx = $config->dbprefix;

$dsn = "mysql:host=$host;dbname=$db";
$opt = array(
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
);

try {
    $pdo = new PDO($dsn, $user, $pass, $opt);
} catch (PDOException $e) {
    die('Connect error: '.$e->getMessage());
}

function getCountProducts($catId = 0)
{
    global $pdo, $prfx;

    $query = "SELECT count(pc.virtuemart_product_id) AS ct "
            ."FROM {$prfx}virtuemart_product_categories pc "
            ."LEFT JOIN {$prfx}virtuemart_products p ON pc.virtuemart_product_id = p.virtuemart_product_id "
            ."WHERE p.published = 1 AND pc.virtuemart_category_id = $catId";
    $stmt  = $pdo->query($query);

    $count = $stmt->fetchColumn();

    $query2     = "SELECT cc.category_child_id "
            ."FROM {$prfx}virtuemart_category_categories cc "
            ."LEFT JOIN {$prfx}virtuemart_categories c ON cc.category_child_id = c.virtuemart_category_id "
            ."WHERE c.published = 1 AND cc.category_parent_id = $catId";
    $stmt2      = $pdo->query($query2);
    $categories = $stmt2->fetchAll(PDO::FETCH_OBJ);

    foreach ($categories as $category) {
        $count += getCountProducts($category->category_child_id);
    }

    $query3 = "UPDATE {$prfx}virtuemart_categories_ru_ru SET count_products = $count WHERE virtuemart_category_id = $catId";
    $stmt3  = $pdo->query($query3);
    $stmt3->execute();

    return $count;
}
getCountProducts();
