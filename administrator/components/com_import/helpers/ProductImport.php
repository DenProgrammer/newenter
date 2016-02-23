<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
ini_set('display_error', true);
error_reporting(E_ALL);

class ProductImport
{

    protected $limit    = 1000;
    protected $limitOrd = 100;
    protected $total;
    protected $totalOrd;
    protected $passw    = 'ofhwoephgepwohg';
    protected $page     = 'http://enter.kg/exportProducts.php';
    protected $pageCat  = 'http://enter.kg/exportCategories.php';
    protected $pageOrd  = 'http://enter.kg/exportOrders.php';
    protected $media    = 'images/stories/virtuemart/';
    protected $user     = 436;
    protected $catId    = null; //array(281, 282);
    protected $iterator = 0;

    /**
     * construct
     */
    public function __construct()
    {
        
    }

    /**
     * execute script
     */
    public function execute()
    {
        $this->clearBase();
//        $this->loadCategories();
        $this->loadTotal();
        $this->loadProducts();
        $this->loadOrders();
    }

    /**
     * load total count products
     */
    public function loadCategories()
    {
        echo "Load categories<br>\n";
        $file = file_get_contents($this->pageCat.'?passw='.$this->passw);
        $this->loadCategoriesCallback($file);
    }

    /**
     * load total count products
     */
    public function loadTotal()
    {
        echo "->\tLoad product total<br>\n";
        echo "->\t{$this->page}?passw={$this->passw}<br>\n";
        $file = file_get_contents($this->page.'?passw='.$this->passw);
        $this->loadTotalCallback($file);

        echo "->\tLoad orders total<br>\n";
        echo "->\t{$this->pageOrd}?passw={$this->passw}<br>\n";
        $file = file_get_contents($this->pageOrd.'?passw='.$this->passw);
        $this->loadTotalOrdersCallback($file);
    }

    /**
     * load products
     */
    public function loadProducts()
    {
        echo "->\tLoad products<br>\n";

        $count = ceil($this->total / $this->limit);

        for ($i = 0; $i < $count; $i++) {
            $offset = $i * $this->limit;
            $url    = $this->page.'?limit='.$this->limit.'&offset='.$offset.'&passw='.$this->passw;
            if ($this->catId) {
                $url.='&catid='.implode(',', $this->catId);
            }
            $file = file_get_contents($url);
            $this->loadProductsCallback($file, $url);
        }
    }

    /**
     * load orders
     */
    public function loadOrders()
    {
        $count = ceil($this->totalOrd / $this->limitOrd);
        try {
            for ($i = 0; $i < $count; $i++) {
                $offset = $i * $this->limitOrd;
                $url    = $this->pageOrd.'?limit='.$this->limitOrd.'&offset='.$offset.'&passw='.$this->passw;
                $file   = file_get_contents($url);
                $this->loadOrdersCallback($file, $url);
            }
        } catch (\Exception $ex) {
            echo $ex->getMessage().', '.$ex->getFile().', '.$ex->getLine();
        }
    }

    /**
     * load categories callback
     * 
     * @param string $response
     * @return null
     */
    public function loadCategoriesCallback($response)
    {
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
     * @return null
     */
    public function loadTotalCallback($response)
    {
        $data = json_decode($response);

        $this->total = $data->total;

        echo "->\tLoad complite, total products ".$this->total."<br>\n";

        return;
    }

    /**
     * load total orders callback
     * 
     * @param string $response
     * @return null
     */
    public function loadTotalOrdersCallback($response)
    {
        $data = json_decode($response);

        $this->totalOrd = $data->total;

        echo "->\tLoad complite, total orders ".$this->totalOrd."<br>\n";

        return;
    }

    /**
     * load product callback
     * 
     * @param string $response
     * @param object $url
     * @return null
     */
    public function loadProductsCallback($response, $url)
    {
        $this->iterator++;

        $data = json_decode($response);

        echo $this->iterator."\t->\tOK\t".$url."<br>\n";

        $countSaved = 0;
        $countSkip  = 0;
        if (isset($data->items) && count($data->items)) {
            foreach ($data->items as $item) {
                if ($this->saveProduct($item)) {
                    $countSaved++;
                } else {
                    $countSkip++;
                }
            }
        }

        echo $this->iterator."\t->\tLoad\t".count($data->items)."\tSaved\t".$countSaved."\tSkip\t".$countSkip."<br>\n";

        return;
    }

    /**
     * load orders callback
     * 
     * @param string $response
     * @param object $url
     * @return null
     */
    public function loadOrdersCallback($response, $url)
    {
        $data = json_decode($response);

        if (!isset($data->orders)) {
            $file = file_get_contents($url);
            $this->loadOrdersCallback($file, $url);
            return;
        }

        $count = 0;
        $skip  = 0;
        foreach ($data->orders as $item) {
            if ($this->saveOrders($item)) {
                $count++;
            } else {
                $skip++;
            }
        }
        echo "->\tOK\t".$url."<br>\n";
        echo "->\tLoad\t".count($data->orders)."\tSave\t".$count."\tSkip\t".$skip."<br>\n";

        return;
    }

    /**
     * save category
     * 
     * @param object $category
     */
    protected function saveCategory($category)
    {
        $db = JFactory::getDbo();

        $media_path           = $this->media.'category/';
        $user_id              = $this->user;
        $category_id          = $category->category_id;
        $category_desc        = $category->category_description;
        $category_name        = $category->category_name;
        $slug                 = rand(1000, 9999).$category_id;
        $category_publish     = ($category->category_publish == 'Y') ? 1 : 0;
        $list_order           = $category->list_order;
        $category_parent_id   = $category->category_parent_id;
        $category_full_image  = ($category->full_image) ? $media_path.$category->full_image : null;
        $category_thumb_image = ($category->thumb_image) ? $media_path.$category->thumb_image : null;

        if (!$category_full_image) {
            $category_full_image = $category_thumb_image;
        }

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
    protected function saveProduct($product)
    {
        $db = JFactory::getDbo();

        $currencies = array(
            'KGS' => 165,
            'USD' => 202,
        );

        $media_path          = $this->media.'product/';
        $user_id             = $this->user;
        $hash                = $product->hash;
        $product_id          = $product->product_id;
        $slug                = rand(1000, 9999).$product_id;
        $category_id         = $product->category_id;
        $product_sku         = $product->product_sku;
        $product_desc        = str_replace('\\', '&#92;', htmlentities($product->product_desc, ENT_QUOTES, 'UTF-8'));
        $product_s_desc      = str_replace('\\', '&#92;', htmlentities($product->product_s_desc, ENT_QUOTES, 'UTF-8'));
        $product_name        = str_replace('\\', '&#92;', htmlentities($product->product_name, ENT_QUOTES, 'UTF-8'));
        $product_price       = $product->product_price;
        $product_publish     = ($product->product_publish === 'Y') ? 1 : 0;
        $product_currency    = $currencies[$product->product_currency];
        $product_full_image  = ($product->full_image) ? $media_path.$product->full_image : null;
        $product_thumb_image = ($product->thumb_image) ? $media_path.$product->thumb_image : null;

        if (!$product_full_image) {
            $product_full_image = $product_thumb_image;
        }

        $checkSql = "SELECT `virtuemart_product_id` FROM `#__virtuemart_products`
                WHERE `virtuemart_product_id` = $product_id LIMIT 1";
        $db->setQuery($checkSql);
        $check    = $db->loadResult();

        if ($check) {
            return false;
        }

        $productSql = "INSERT INTO `#__virtuemart_products`(
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
                0, '2015-1-1 00:00:00', '', 0, 0, 
                'KG', NULL, 'min_order_level=\"\"|max_order_level=\"\"|step_order_level=\"\"|product_box=\"\"|', NULL, '', 
                '', '', '0', $product_publish, 0, 
                '2015-1-1 00:00:00', $user_id, '2015-1-1 00:00:00', $user_id, '0000-0-0 00:00:00', 0)";
        $db->setQuery($productSql);
        $db->query();

        $productRuSql = "INSERT INTO `#__virtuemart_products_ru_ru` (
                `virtuemart_product_id`, `product_s_desc`, `product_desc`, `product_name`, `metadesc`, 
                `metakey`, `customtitle`, `slug`, `hash`
                ) VALUES (
                $product_id, '$product_s_desc', '$product_desc', '$product_name', '', 
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

        return true;
    }

    /**
     * save orders
     * 
     * @param object $product
     */
    protected function saveOrders($order)
    {
        $db = JFactory::getDbo();

        $order_id = $order->order_id;
        $user_id  = 0; //$order->user_id;
        $currency = 202;
        $delivery = $order->delivery;
        $total    = ($order->order_currency == 'USD') ? $order->order_total : $order->order_total / $delivery;
        $cdate    = date('Y-m-d H:i:s', $order->cdate);
        $note     = $order->customer_note;
        $ip       = $order->ip_address;
        $exchange = $order->exchange_usd;
        $nrt      = $order->nrt;
        $name     = $order->first_name;
        $phone    = $order->phone_1;
        $address  = $order->address_1;

        $order_number = $this->generateOrderNumber($user_id);
        $order_pass   = 'p_'.substr(md5((string) time().rand(1, 1000).$order_number), 0, 5);

        $checkSql = "SELECT `virtuemart_order_id` "
                ."FROM `#__virtuemart_orders` "
                ."WHERE `virtuemart_order_id` = $order_id";
        $db->setQuery($checkSql);
        $check    = $db->loadResult();

        if ($check) {
            return false;
        }

        $sqlDump = '';

        $ordersSql = "INSERT INTO `#__virtuemart_orders` ("
                ."`virtuemart_order_id`, `virtuemart_user_id`, `virtuemart_vendor_id`, `order_number`, "
                ."`customer_number`, `order_pass`, `order_total`, `order_salesPrice`, `order_billTaxAmount`, "
                ."`order_billTax`, `order_billDiscountAmount`, `order_discountAmount`, `order_subtotal`, "
                ."`order_tax`, `order_shipment`, `order_shipment_tax`, `order_payment`, "
                ."`order_payment_tax`, `coupon_discount`, `coupon_code`, `order_discount`, "
                ."`order_currency`, `order_status`, `user_currency_id`, `user_currency_rate`, "
                ."`virtuemart_paymentmethod_id`, `virtuemart_shipmentmethod_id`, `delivery_date`, `order_language`, "
                ."`ip_address`, `created_on`, `created_by`, `modified_on`, "
                ."`modified_by`, `locked_on`, `locked_by`, `vendor_info_id`, "
                ."`shoper_info`, `nrt`, `exchange_usd`, `delivery`"
                .") VALUES ("
                ."$order_id, 0, 1, '$order_number', "
                ."'nonreg_$name', '$order_pass', $total, $total, 0.00000, "
                ."'0', 0.00000, 0.00000, $total, "
                ."0.00000, 0.00, 0.00000, 0.00, "
                ."0.00000, 0.00, NULL, 0.00, "
                ."$currency, 'U', $currency, 1.00000, "
                ."1, 1, 'Такая же как и дата выписки счета', 'ru-RU', "
                ."'$ip', '$cdate', 0, '$cdate', "
                ."0, '0000-0-0 00:00:00', 0, '', "
                ."NULL, $nrt, $exchange, $delivery);";

        $sqlDump .= $ordersSql."\n";
        $db->setQuery($ordersSql);
        $db->query();

        $userInfosSql = "INSERT INTO `#__virtuemart_order_userinfos` ("
                ."`virtuemart_order_id`, `virtuemart_user_id`, `address_type`, "
                ."`address_type_name`, `company`, `title`, `last_name`, "
                ."`first_name`, `middle_name`, `phone_1`, `phone_2`, "
                ."`fax`, `address_1`, `address_2`, `city`, "
                ."`virtuemart_state_id`, `virtuemart_country_id`, `zip`, `email`, "
                ."`agreed`, `tos`, `customer_note`, `created_on`, "
                ."`created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`"
                .") VALUES ("
                ."$order_id, $user_id, 'BT', "
                ."NULL, NULL, NULL, NULL, "
                ."'$name', NULL, '$phone', NULL, "
                ."NULL, '$address', NULL, '', "
                ."0, 0, '', NULL, "
                ."0, 0, '$note', '$cdate', "
                ."0, '$cdate', 0, '0000-0-0 00:00:00', 0);";
        $sqlDump .= $userInfosSql."\n";
        $db->setQuery($userInfosSql);
        $db->query();

        $orderHistoriesSql = "INSERT INTO `#__virtuemart_order_histories` ("
                ."`virtuemart_order_id`, `order_status_code`, `customer_notified`, "
                ."`comments`, `published`, `created_on`, `created_by`, "
                ."`modified_on`, `modified_by`, `locked_on`, `locked_by`"
                .") VALUES ("
                ."$order_id, 'P', 0, "
                ."'', 1, '$cdate', 0, "
                ."'$cdate', 0, '0000-0-0 00:00:00', 0);";
        $sqlDump .= $orderHistoriesSql."\n";
        $db->setQuery($orderHistoriesSql);
        $db->query();

        $orderHistoriesSql2 = "INSERT INTO `#__virtuemart_order_histories` ("
                ."`virtuemart_order_id`, `order_status_code`, `customer_notified`, "
                ."`comments`, `published`, `created_on`, `created_by`, "
                ."`modified_on`, `modified_by`, `locked_on`, `locked_by`"
                .") VALUES ("
                ."$order_id, 'U', 1, "
                ."'', 1, '$cdate', 0, "
                ."'$cdate', 0, '0000-0-0 00:00:00', 0);";
        $sqlDump .= $orderHistoriesSql2."\n";
        $db->setQuery($orderHistoriesSql2);
        $db->query();

        $orderCalcRulesSql = "INSERT INTO `#__virtuemart_order_calc_rules` ("
                ."`virtuemart_calc_id`, `virtuemart_order_id`, `virtuemart_vendor_id`, "
                ."`virtuemart_order_item_id`, `calc_rule_name`, `calc_kind`, "
                ."`calc_mathop`, `calc_amount`, `calc_result`, "
                ."`calc_value`, `calc_currency`, `calc_params`, "
                ."`created_on`, `created_by`, `modified_on`, "
                ."`modified_by`, `locked_on`, `locked_by`"
                .") VALUES ("
                ."0, $order_id, 1, "
                ."NULL, '', 'payment', "
                ."'', 0.00000, 0.00000, "
                ."0.00000, 0, '', "
                ."'$cdate', 0, '$cdate', "
                ."0, '0000-0-0 00:00:00', 0);";
        $sqlDump .= $orderCalcRulesSql."\n";
        $db->setQuery($orderCalcRulesSql);
        $db->query();

        $orderCalcRulesSql2 = "INSERT INTO `#__virtuemart_order_calc_rules` ("
                ."`virtuemart_calc_id`, `virtuemart_order_id`, `virtuemart_vendor_id`, "
                ."`virtuemart_order_item_id`, `calc_rule_name`, `calc_kind`, "
                ."`calc_mathop`, `calc_amount`, `calc_result`, "
                ."`calc_value`, `calc_currency`, `calc_params`, "
                ."`created_on`, `created_by`, `modified_on`, "
                ."`modified_by`, `locked_on`, `locked_by`"
                .") VALUES ("
                ."0, $order_id, 1, "
                ."NULL, '', 'shipment', "
                ."'', 0.00000, 0.00000, "
                ."0.00000, 0, '', "
                ."'$cdate', 0, '$cdate', "
                ."0, '0000-0-0 00:00:00', 0);";
        $sqlDump .= $orderCalcRulesSql2."\n";
        $db->setQuery($orderCalcRulesSql2);
        $db->query();

        foreach ($order->items as $item) {
            $product_id  = $item->product_id;
            $item_sku    = $item->order_item_sku;
            $item_name   = $item->order_item_name;
            $quantity    = $item->product_quantity;
            $currency    = $item->order_item_currency;
            $item_price  = $currency == 'USD' ? $item->product_item_price : $item->product_item_price / $delivery;
            $final_price = $currency == 'USD' ? $item->product_final_price : $item->product_final_price / $delivery;

            $itemSql = "INSERT INTO `#__virtuemart_order_items` ("
                    ."`virtuemart_order_id`, `virtuemart_vendor_id`, `virtuemart_product_id`, "
                    ."`order_item_sku`, `order_item_name`, `product_quantity`, `product_item_price`, "
                    ."`product_priceWithoutTax`, `product_tax`, `product_basePriceWithTax`, `product_discountedPriceWithoutTax`, "
                    ."`product_final_price`, `product_subtotal_discount`, `product_subtotal_with_tax`, `order_item_currency`, "
                    ."`order_status`, `product_attribute`, `delivery_date`, `created_on`, "
                    ."`created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`"
                    .") VALUES ("
                    ."$order_id, 1, $product_id, "
                    ."'$item_sku', '$item_name', $quantity, $item_price, "
                    ."$item_price, 0.00000, 0.00000, $item_price, "
                    ."$item_price, 0.00000, $final_price, NULL, "
                    ."'U', '[]', NULL, '$cdate', "
                    ."0, '$cdate', 0, '0000-0-0 00:00:00', 0);";
            $sqlDump .= $itemSql."\n";
            $db->setQuery($itemSql);
            $db->query();
        }

//        echo $sqlDump,"<br><br>\n\n";
//        file_put_contents('dump.sql', str_replace('#__','wy587_',$sqlDump), FILE_APPEND);

        return true;
    }

    /**
     * generate order number
     * @param type $uid
     * @param type $length
     * @return string
     */
    public function generateOrderNumber($uid = 0, $length = 4)
    {
        $data = substr(md5(session_id().(string) time().(string) $uid)
                        , 0
                        , $length
                ).'0'.rand(0, 99);

        return $data;
    }

    /**
     * clear base
     */
    protected function clearBase()
    {
        $db = JFactory::getDbo();

        $db->setQuery('TRUNCATE TABLE `#__virtuemart_products`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_products_ru_ru`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_prices`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_categories`');
        $db->query();
        $db->setQuery('TRUNCATE TABLE `#__virtuemart_product_medias`');
        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_medias`');
        $db->setQuery('DELETE FROM `#__virtuemart_medias` WHERE file_type = "product"');
        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_categories`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_categories_ru_ru`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_category_categories`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_category_medias`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_order_items`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_order_userinfos`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_order_histories`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_order_calc_rules`');
//        $db->query();
//        $db->setQuery('TRUNCATE TABLE `#__virtuemart_orders`');
//        $db->query();
    }

    /**
     * get file title
     * 
     * @param object $product
     * @return string
     */
    protected function getFileTitle($product)
    {
        $full  = $product->full_image;
        $thumb = $product->thumb_image;
        if ($full) {
            $array = explode('.', $full);
            $title = end($array);
        } elseif ($thumb) {
            $array = explode('.', $thumb);
            $title = end($array);
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
    protected function getFileMimetype($product)
    {
        if ($product->full_image) {
            $image = $product->full_image;
            $array = explode('.', $image);
            $ext   = end($array);

            if (in_array($ext, array('png', 'jpg', 'gif'))) {
                return 'image/'.$ext;
            }
        }

        return null;
    }
}
