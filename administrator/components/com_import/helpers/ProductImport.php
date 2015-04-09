<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class ProductImport {

    protected $AC1;
    protected $AC2;
    protected $AC3;
    protected $limit   = 1000;
    protected $total;
    protected $passw   = 'ofhwoephgepwohg';
    protected $page    = 'http://enter.kg/exportProducts.php';
    protected $pageCat = 'http://enter.kg/exportCategories.php';
    protected $media   = 'images/stories/virtuemart/';
    protected $user    = 436;

    /**
     * construct
     */
    public function __construct() {
        $this->AC1 = new AngryCurl(array($this, 'loadCategoriesCallback'));
        $this->AC1->init_console();

        $this->AC2 = new AngryCurl(array($this, 'loadTotalCallback'));
        $this->AC2->init_console();

        $this->AC3 = new AngryCurl(array($this, 'loadProductsCallback'));
        $this->AC3->init_console();
    }

    /**
     * destruct
     */
    public function __destruct() {
        unset($this->AC1, $this->AC2, $this->AC3);
    }

    /**
     * execute script
     */
    public function execute() {
        $this->clearBase();
        $this->loadCategories();
        $this->loadTotal();
        $this->loadProducts();
    }

    /**
     * load total count products
     */
    public function loadCategories() {
        $this->AC1->get($this->pageCat . '?passw=' . $this->passw);

        AngryCurl::add_debug_msg('Load categories');

        $this->AC1->execute(2);
    }

    /**
     * load total count products
     */
    public function loadTotal() {
        $this->AC2->get($this->page . '?passw=' . $this->passw);

        AngryCurl::add_debug_msg('Load product total');

        $this->AC2->execute(2);
    }

    /**
     * load products
     */
    public function loadProducts() {

        $count = ceil($this->total / $this->limit);

        for ($i = 0; $i < $count; $i++) {
            $offset = $i * $this->limit;
            $url    = $this->page . '?limit=' . $this->limit . '&offset=' . $offset . '&passw=' . $this->passw;
            $this->AC3->get($url);
        }

        $this->AC3->execute(200);
    }

    /**
     * load categories callback
     * 
     * @param string $response
     * @param array  $info
     * @param object $request
     * @return null
     */
    public function loadCategoriesCallback($response, $info, $request) {
        if ($info['http_code'] !== 200) {
            return;
        }

        AngryCurl::add_debug_msg(
                "->\t" . $request->options[CURLOPT_PROXY] . "\tOK\t" . $info['http_code'] .
                "\t" . $info['total_time'] . "\t" . $info['url']
        );

        $data = json_decode($response);

        foreach ($data->items as $item) {
            $this->saveCategory($item);
        }

        return;
    }

    /**
     * load total callback
     * 
     * @param string $response
     * @param array  $info
     * @param object $request
     * @return null
     */
    public function loadTotalCallback($response, $info, $request) {
        if ($info['http_code'] !== 200) {
            return;
        }

        $data = json_decode($response);

        $this->total = $data->total;

        AngryCurl::add_debug_msg('Load complite, total ' . $this->total);

        return;
    }

    /**
     * load product callback
     * 
     * @param string $response
     * @param array  $info
     * @param object $request
     * @return null
     */
    public function loadProductsCallback($response, $info, $request) {
        if ($info['http_code'] !== 200) {
            return;
        }

        AngryCurl::add_debug_msg(
                "->\t" . $request->options[CURLOPT_PROXY] . "\tOK\t" . $info['http_code'] .
                "\t" . $info['total_time'] . "\t" . $info['url']
        );

        $data = json_decode($response);

        foreach ($data->items as $item) {
            $this->saveProduct($item);
        }

        return;
    }

    /**
     * save product
     * 
     * @param object $product
     */
    protected function saveCategory($category) {
        $db = JFactory::getDbo();

        $media_path           = $this->media . 'category/';
        $user_id              = $this->user;
        $category_id          = $category->category_id;
        $category_desc        = str_replace('\\', '&#92;', htmlentities($category->category_description, ENT_QUOTES, 'UTF-8'));
        $category_name        = str_replace('\\', '&#92;', htmlentities($category->category_name, ENT_QUOTES, 'UTF-8'));
        $slug                 = rand(1000, 9999) . $category_id;
        $category_publish     = ($category->category_publish == 'Y') ? 1 : 0;
        $list_order           = $category->list_order;
        $category_parent_id   = $category->category_parent_id;
        $category_full_image  = ($category->full_image) ? $media_path . $category->full_image : null;
        $category_thumb_image = ($category->thumb_image) ? $media_path . $category->thumb_image : null;

        $categorySql = "INSERT INTO `#__virtuemart_categories` (
                `virtuemart_category_id`, `virtuemart_vendor_id`, `category_template`, `category_layout`, 
                `category_product_layout`, `products_per_row`, `limit_list_step`, `limit_list_initial`, 
                `hits`, `metarobot`, `metaauthor`, `ordering`, 
                `shared`, `published`, `created_on`, `created_by`, 
                `modified_on`, `modified_by`, `locked_on`, `locked_by`
                ) VALUES (
                $category_id, 1, '0', '0', 
                '0', 0, '0', 0, 
                0, '', '', $list_order, 
                0, $category_publish, '2015-1-1 00:00:00', $user_id, 
                '2015-1-1 00:00:00', $user_id, '0000-0-0 00:00:00', 0)";
        $db->setQuery($categorySql);
        $db->query();

        $categoryRuSql = "INSERT INTO `#__virtuemart_categories_ru_ru` (
                `virtuemart_category_id`, `category_name`, `category_description`, `metadesc`, 
                `metakey`, `customtitle`, `slug`
                ) VALUES (
                $category_id, '$category_name', '$category_desc', '', 
                '', '', '$slug')";
        $db->setQuery($categoryRuSql);
        $db->query();

        $categoryCategoriesSql = "INSERT INTO `#__virtuemart_category_categories` (
                `category_parent_id`, `category_child_id`, `ordering`
                ) VALUES (
                $category_parent_id, $category_id, $list_order)";
        $db->setQuery($categoryCategoriesSql);
        $db->query();

        if ($category_full_image || $category_thumb_image) {
            $file_title = $this->getFileTitle($category);
            $mime_type  = $this->getFileMimetype($category);

            $mediaSql = "INSERT INTO `#__virtuemart_medias` (
                    `virtuemart_vendor_id`, `file_title`, `file_description`, `file_meta`, 
                    `file_mimetype`, `file_type`, `file_url`, `file_url_thumb`, 
                    `file_is_product_image`, `file_is_downloadable`, `file_is_forSale`, `file_params`, 
                    `file_lang`, `shared`, `published`, `created_on`, 
                    `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`
                    ) VALUES (
                    1, '$file_title', '', '', 
                    '$mime_type', 'category', '$category_full_image', '$category_thumb_image', 
                    0, 0, 0, '', 
                    '', 0, 1, '2015-1-1 00:00:00', 
                    $user_id, '2015-1-1 00:00:00', $user_id, '0000-0-0 00:00:00', 0)";
            $db->setQuery($mediaSql);
            $db->query();

            $media_id = $db->insertid();

            $mediaProductSql = "INSERT INTO `#__virtuemart_category_medias` (
                    `virtuemart_category_id`, `virtuemart_media_id`, `ordering`
                    ) VALUES (
                    $category_id, $media_id, 1)";
            $db->setQuery($mediaProductSql);
            $db->query();
        }
    }

    /**
     * save product
     * 
     * @param object $product
     */
    protected function saveProduct($product) {
        $db = JFactory::getDbo();

        $currencies = array(
            'KGS' => 165,
            'USD' => 202,
        );

        $media_path          = $this->media . 'product/';
        $user_id             = $this->user;
        $hash                = $product->hash;
        $product_id          = $product->product_id;
        $slug                = rand(1000, 9999) . $product_id;
        $category_id         = $product->category_id;
        $product_sku         = $product->product_sku;
        $product_desc        = str_replace('\\', '&#92;', htmlentities($product->product_desc, ENT_QUOTES, 'UTF-8'));
        $product_name        = str_replace('\\', '&#92;', htmlentities($product->product_name, ENT_QUOTES, 'UTF-8'));
        $product_price       = $product->product_price;
        $product_publish     = ($product->product_publish == 'Y') ? 1 : 0;
        $product_currency    = $currencies[$product->product_currency];
        $product_full_image  = ($product->full_image) ? $media_path . $product->full_image : null;
        $product_thumb_image = ($product->thumb_image) ? $media_path . $product->thumb_image : null;

        $productSql = "INSERT IGNORE INTO `#__virtuemart_products`(
                `virtuemart_product_id`, `virtuemart_vendor_id`, `product_parent_id`, `product_sku`, `product_gtin`, 
                `product_mpn`, `product_weight`, `product_weight_uom`, `product_length`, `product_width`, 
                `product_height`, `product_lwh_uom`, `product_url`, `product_in_stock`, `product_ordered`, 
                `low_stock_notification`, `product_available_date`, `product_availability`, `product_special`, `product_sales`, 
                `product_unit`, `product_packaging`, `product_params`, `hits`, `intnotes`, 
                `metarobot`, `metaauthor`, `layout`, `published`, `pordering`, 
                `created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`
                )  VALUES (
                $product_id, 1, 0, '$product_sku', '', 
                '', NULL, 'KG', NULL, NULL, 
                NULL, 'M', '', 0, 0, 
                0, '2015-1-1 00:00:00', '', $product_publish, 0, 
                'KG', NULL, 'min_order_level=\"\"|max_order_level=\"\"|step_order_level=\"\"|product_box=\"\"|', NULL, '', 
                '', '', '0', 1, 0, 
                '2015-1-1 00:00:00', $user_id, '2015-1-1 00:00:00', $user_id, '0000-0-0 00:00:00', 0)";
        $db->setQuery($productSql);
        $db->query();

        $productRuSql = "INSERT IGNORE INTO `#__virtuemart_products_ru_ru` (
                `virtuemart_product_id`, `product_s_desc`, `product_desc`, `product_name`, `metadesc`, 
                `metakey`, `customtitle`, `slug`, `hash`
                ) VALUES (
                $product_id, '', '$product_desc', '$product_name', '', 
                '', '', '$slug', '$hash')";
        $db->setQuery($productRuSql);
        $db->query();

        $pricesSql = "INSERT INTO `#__virtuemart_product_prices` (
            `virtuemart_product_id`, `virtuemart_shoppergroup_id`, `product_price`, `override`, `product_override_price`, 
            `product_tax_id`, `product_discount_id`, `product_currency`, `product_price_publish_up`, `product_price_publish_down`, 
            `price_quantity_start`, `price_quantity_end`, `created_on`, `created_by`, `modified_on`, 
            `modified_by`, `locked_on`, `locked_by`
            ) VALUES (
            $product_id, 0, $product_price, 0, 0.00000, 
            -1, 0, $product_currency, '0000-0-0 00:00:00', '0000-0-0 00:00:00', 
            0, 0, '2015-1-1 00:00:00', $user_id, '2015-1-1 00:00:00', 
            $user_id, '0000-0-0 00:00:00', 0)";
        $db->setQuery($pricesSql);
        $db->query();

        $categoriesSql = "INSERT INTO `#__virtuemart_product_categories` (
            `virtuemart_product_id`, `virtuemart_category_id`, `ordering`
            ) VALUES (
            $product_id, $category_id, 0)";
        $db->setQuery($categoriesSql);
        $db->query();

        if ($product_full_image || $product_thumb_image) {
            $file_title = $this->getFileTitle($product);
            $mime_type  = $this->getFileMimetype($product);

            $mediaSql = "INSERT INTO `#__virtuemart_medias` (
                    `virtuemart_vendor_id`, `file_title`, `file_description`, `file_meta`, 
                    `file_mimetype`, `file_type`, `file_url`, `file_url_thumb`, 
                    `file_is_product_image`, `file_is_downloadable`, `file_is_forSale`, `file_params`, 
                    `file_lang`, `shared`, `published`, `created_on`, 
                    `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`
                    ) VALUES (
                    1, '$file_title', '', '', 
                    '$mime_type', 'product', '$product_full_image', '$product_thumb_image', 
                    0, 0, 0, '', 
                    '', 0, 1, '2015-1-1 00:00:00', 
                    $user_id, '2015-1-1 00:00:00', $user_id, '0000-0-0 00:00:00', 0)";
            $db->setQuery($mediaSql);
            $db->query();

            $media_id = $db->insertid();

            $mediaProductSql = "INSERT INTO `#__virtuemart_product_medias` (
                    `virtuemart_product_id`, `virtuemart_media_id`, `ordering`
                    ) VALUES (
                    $product_id, $media_id, 1)";
            $db->setQuery($mediaProductSql);
            $db->query();
        }
    }

    /**
     * clear base
     */
    protected function clearBase() {
        $db = JFactory::getDbo();

        $db->setQuery('TRUNCATE TABLE `#__virtuemart_products`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_products_ru_ru`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_prices`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_categories`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_medias`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_medias`');
        $db->query();
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_categories`');
        $db->query();
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_categories_ru_ru`');
        $db->query();
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_category_categories`');
        $db->query();
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_category_medias`');
        $db->query();
    }

    /**
     * get file title
     * 
     * @param object $product
     * @return string
     */
    protected function getFileTitle($product) {
        if ($product->full_image) {
            $title = end(explode('/', $product->full_image));
        } elseif ($product->thumb_image) {
            $title = end(explode('/', $product->thumb_image));
        } else {
            $title = 'image';
        }

        return $title;
    }

    /**
     * get file mimetype
     * 
     * @param object $product
     * @return string
     */
    protected function getFileMimetype($product) {
        if ($product->full_image) {
            $ext = end(explode('.', $product->full_image));

            if (in_array($ext, array('png', 'jpg', 'gif'))) {
                return 'image/' . $ext;
            }
        }

        return null;
    }

}
