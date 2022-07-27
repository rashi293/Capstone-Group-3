-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens



ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Home & Furniture', 0, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Wodden Furniture', 1, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Lightings', 2, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Interiors', 3, '2022-07-07 23:03:26', '2022-07-07 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-07-07 23:03:26', 'Omura Study Table With Cabinets In Wenge Finish By Mintwud', 'https://ii1.pepperfry.com/media/catalog/product/o/m/800x880/omura-study-table-with-cabinets-in-wenge-finish-by-mintwud-omura-study-table-with-cabinets-in-wenge--3eo8ld.jpg', 'Omura Study Table', 50000.00, 0, 22, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-07-07 23:03:26', 'Ergonomically designed to fit into any home and fit any person. Engineered for luxury & comfort, this is a sofa that will leave you feeling blissful.', 'https://mysleepyhead.com/media/catalog/product/cache/208fb0ae1c70eca4ffa059c65c5c5342/l/s/ls1_2.jpg', 'Sofa Yolo - Modern Upholstered Sofa With Ergonomic Design', 65.00, 0, 60, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-07-07 23:03:26', 'Do not move or push without dismantling. Do not use acid to clean. Do not abuse closing by legs. Use dry cloth to wipe furniture. Do not lift the furniture by holding top. Do not put water on it. Do not expose to sun', 'https://cdn.shopify.com/s/files/1/0044/1208/0217/products/MWILLY3DRWBWOMWEN_LF_800x.jpg?v=1610476670', 'Nilkamal Willy 3 Door Wardrobe', 45.00, 0, 40, '2022-07-07 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-07-07 23:03:26', 'The color of the product we ship is the color in the first picture, and the specification and quantity are shipped according to the quantity and specification described in the title.
If you need to change the color or style, you need to contact us within 12 hours after placing the order.', 'https://img.fruugo.com/product/4/27/158999274_max.jpg', 'new dollhouse miniature dining table chair wooden furniture set sm4853', 53.00, 0, 22, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-07-07 23:03:26', 'Solid Wood mirror Dresser - Natural Tone', 'https://cdn.shopify.com/s/files/1/0020/4020/1328/collections/SGHWS0666_1_400x.jpg?v=1649933136', 'Solid Wood mirror Dresser', 85.00, 0, 10, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-07-07 23:03:26', '
Riding on huge volume of industry expertise, we are indulged in offering a beautifully designed assortment of Custom Made Solid Wood Furniture. These offered products are widely attributed in the industry for their flawless finish and durable nature. Along with this, we assure that only supreme-grade factory material is utilized in their manufacturing process', 'https://3.imimg.com/data3/BK/JF/MY-2180896/custom-made-solid-wood-furniture-500x500.jpg', 'Custom Made Solid Wood Furniture', 45.00, 0, 50, '2022-07-07 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-07-07 23:03:26', 'Moon Disc - Edged Round Glow - LED Mirror - Natural White Light - Round', 'https://cdn.shopify.com/s/files/1/0263/1899/5504/products/circularedgeledwhitelight0101_720x.jpg?v=1655387952', 'Moon Disc - Edged Round Glow ', 199.00, 0, 45, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-07-07 23:03:26', 'Light body material: iron, shade Material: glass
capacity: maximum 40W{not included}, voltage: 111-220V, irradiation area: 5 ㎡-10 ㎡.
high-quality iron materials, high temperature paint, multi-channel', 'https://cdn.shopify.com/s/files/1/0536/0651/4852/products/1_b86479e7-e0ae-499e-a3fa-3dbc1ed153ec_1024x1024@2x.jpg?v=1657631157', '500MM GOLD LONG WALL LIGHT METAL - GOLD WARM WHITE', 57.00, 0, 53, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-07-07 23:03:26', 'Requires 2 E-14 Bulbs (Not Included) Design: Post-modern creative design wall-mounted fixture, gold metal tube & transparent crystal tube combination wall lamp, to meet the auxiliary lighting needs of your room.', 'https://cdn.shopify.com/s/files/1/0536/0651/4852/products/1_06c40a85-a442-4a7b-9dce-023ca19be8ab_1024x1024@2x.jpg?v=1657631038', '32W 500MM LED TUBE GLASS CRYSTAL GOLD METAL WALL LIGHT - WARM WHITE ', 95.00, 0, 70, '2022-07-07 23:03:26');


INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-07-07 23:03:26', 'Height: 210 cm
Length: 210 cm
Machine wash
2 Door Curtain
Material::Polyester
Pattern::Floral
Breadth: 115 cm
Weight: 425 gm
Polyester
Semi-Sheer', 'https://assets.ajio.com/medias/sys_master/root/20220222/JGxP/62147f83aeb26921afaaae8c/-473Wx593H-461768801-white-MODEL.jpg', 'Floral Print Semi-Sheer Door Curtains ', 90.00, 0, 39, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-07-07 23:03:26', 'Cotton Eyelet LUXURY CURTAINS, Size: 2.5 Meter, Length: 7.5 Feet', 'https://5.imimg.com/data5/BY/LJ/PQ/SELLER-36485110/07777-500x500.jpg', 'Cotton Eyelet LUXURY CURTAINS', 76.00, 0, 75, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-07-07 23:03:26', 'Superior quality
Available in different shapes
Varied sizes', 'https://3.imimg.com/data3/HX/QH/MY-15162596/sofa-mats-500x500.jpg', 'Sofa Mats', 82.00, 0, 20, '2022-07-07 23:03:26');




------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
