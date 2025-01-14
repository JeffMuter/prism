PGDMP      2    
            |           postgres    16.3    16.3 c    /           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            0           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            1           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            2           1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false            3           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4914                        2615    40983    schema    SCHEMA        CREATE SCHEMA schema;
    DROP SCHEMA schema;
                postgres    false                        2615    40994    schema_name    SCHEMA        CREATE SCHEMA schema_name;
    DROP SCHEMA schema_name;
                postgres    false                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            4           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    57411    location_types    TABLE     `   CREATE TABLE public.location_types (
    id integer NOT NULL,
    name character varying(50)
);
 "   DROP TABLE public.location_types;
       public         heap    postgres    false            �            1259    57410    location_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.location_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.location_types_id_seq;
       public          postgres    false    235            5           0    0    location_types_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.location_types_id_seq OWNED BY public.location_types.id;
          public          postgres    false    234            �            1259    57435    location_types_tasks    TABLE     ~   CREATE TABLE public.location_types_tasks (
    id integer NOT NULL,
    task_type_id integer,
    location_type_id integer
);
 (   DROP TABLE public.location_types_tasks;
       public         heap    postgres    false            �            1259    57434    location_types_tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.location_types_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.location_types_tasks_id_seq;
       public          postgres    false    237            6           0    0    location_types_tasks_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.location_types_tasks_id_seq OWNED BY public.location_types_tasks.id;
          public          postgres    false    236            �            1259    25144 	   locations    TABLE       CREATE TABLE public.locations (
    id integer NOT NULL,
    default_accessible boolean DEFAULT true,
    location_type character varying(50) NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    name text,
    description text,
    art text
);
    DROP TABLE public.locations;
       public         heap    postgres    false            �            1259    25143    locations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.locations_id_seq;
       public          postgres    false    225            7           0    0    locations_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
          public          postgres    false    224            �            1259    57474    locations_resources    TABLE     w   CREATE TABLE public.locations_resources (
    id integer NOT NULL,
    location_id integer,
    resource_id integer
);
 '   DROP TABLE public.locations_resources;
       public         heap    postgres    false            �            1259    57473    locations_resources_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locations_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.locations_resources_id_seq;
       public          postgres    false    239            8           0    0    locations_resources_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.locations_resources_id_seq OWNED BY public.locations_resources.id;
          public          postgres    false    238            �            1259    25122 	   resources    TABLE     [   CREATE TABLE public.resources (
    id integer NOT NULL,
    name character varying(50)
);
    DROP TABLE public.resources;
       public         heap    postgres    false            �            1259    25121    resources_id_seq    SEQUENCE     �   CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.resources_id_seq;
       public          postgres    false    221            9           0    0    resources_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;
          public          postgres    false    220            �            1259    49188    task_types_resources    TABLE     y   CREATE TABLE public.task_types_resources (
    id integer NOT NULL,
    task_type_id integer,
    resource_id integer
);
 (   DROP TABLE public.task_types_resources;
       public         heap    postgres    false            �            1259    49187    task_type_resource_id_seq    SEQUENCE     �   CREATE SEQUENCE public.task_type_resource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.task_type_resource_id_seq;
       public          postgres    false    231            :           0    0    task_type_resource_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.task_type_resource_id_seq OWNED BY public.task_types_resources.id;
          public          postgres    false    230            �            1259    49181 
   task_types    TABLE     \   CREATE TABLE public.task_types (
    id integer NOT NULL,
    name character varying(50)
);
    DROP TABLE public.task_types;
       public         heap    postgres    false            �            1259    49180    task_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.task_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.task_types_id_seq;
       public          postgres    false    229            ;           0    0    task_types_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.task_types_id_seq OWNED BY public.task_types.id;
          public          postgres    false    228            �            1259    25154    users_locations    TABLE     �   CREATE TABLE public.users_locations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    location_id integer NOT NULL,
    named character varying(100),
    worker_count integer DEFAULT 0 NOT NULL
);
 #   DROP TABLE public.users_locations;
       public         heap    postgres    false            �            1259    25153    user_locations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.user_locations_id_seq;
       public          postgres    false    227            <           0    0    user_locations_id_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public.user_locations_id_seq OWNED BY public.users_locations.id;
          public          postgres    false    226            �            1259    25112    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    25111    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    219            =           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    218            �            1259    25129    workers    TABLE     Z  CREATE TABLE public.workers (
    id integer NOT NULL,
    religion character varying(50),
    age integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    work_status boolean DEFAULT false,
    injured boolean DEFAULT false,
    strength integer NOT NULL,
    intelligence integer NOT NULL,
    faith integer NOT NULL,
    user_locations_id integer NOT NULL,
    travel_speed integer DEFAULT 0 NOT NULL,
    work_speed integer DEFAULT 0 NOT NULL,
    stamina integer DEFAULT 0 NOT NULL,
    max_stamina integer DEFAULT 10 NOT NULL
);
    DROP TABLE public.workers;
       public         heap    postgres    false            �            1259    25128    workers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.workers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.workers_id_seq;
       public          postgres    false    223            >           0    0    workers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.workers_id_seq OWNED BY public.workers.id;
          public          postgres    false    222            �            1259    57375    workers_tasks    TABLE     �  CREATE TABLE public.workers_tasks (
    id integer NOT NULL,
    task_type_id integer,
    location_id integer,
    worker_id integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    start_longitude double precision,
    start_latitude double precision,
    end_longitude double precision,
    end_latitude double precision,
    is_ongoing boolean
);
 !   DROP TABLE public.workers_tasks;
       public         heap    postgres    false            �            1259    57374    workers_tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.workers_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.workers_tasks_id_seq;
       public          postgres    false    233            ?           0    0    workers_tasks_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.workers_tasks_id_seq OWNED BY public.workers_tasks.id;
          public          postgres    false    232            a           2604    57414    location_types id    DEFAULT     v   ALTER TABLE ONLY public.location_types ALTER COLUMN id SET DEFAULT nextval('public.location_types_id_seq'::regclass);
 @   ALTER TABLE public.location_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            b           2604    57438    location_types_tasks id    DEFAULT     �   ALTER TABLE ONLY public.location_types_tasks ALTER COLUMN id SET DEFAULT nextval('public.location_types_tasks_id_seq'::regclass);
 F   ALTER TABLE public.location_types_tasks ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    237    237            Z           2604    25147    locations id    DEFAULT     l   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            c           2604    57477    locations_resources id    DEFAULT     �   ALTER TABLE ONLY public.locations_resources ALTER COLUMN id SET DEFAULT nextval('public.locations_resources_id_seq'::regclass);
 E   ALTER TABLE public.locations_resources ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            Q           2604    25125    resources id    DEFAULT     l   ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);
 ;   ALTER TABLE public.resources ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            ^           2604    49184    task_types id    DEFAULT     n   ALTER TABLE ONLY public.task_types ALTER COLUMN id SET DEFAULT nextval('public.task_types_id_seq'::regclass);
 <   ALTER TABLE public.task_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            _           2604    49191    task_types_resources id    DEFAULT     �   ALTER TABLE ONLY public.task_types_resources ALTER COLUMN id SET DEFAULT nextval('public.task_type_resource_id_seq'::regclass);
 F   ALTER TABLE public.task_types_resources ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230    231            O           2604    25115    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            \           2604    25157    users_locations id    DEFAULT     w   ALTER TABLE ONLY public.users_locations ALTER COLUMN id SET DEFAULT nextval('public.user_locations_id_seq'::regclass);
 A   ALTER TABLE public.users_locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            R           2604    25132 
   workers id    DEFAULT     h   ALTER TABLE ONLY public.workers ALTER COLUMN id SET DEFAULT nextval('public.workers_id_seq'::regclass);
 9   ALTER TABLE public.workers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            `           2604    57378    workers_tasks id    DEFAULT     t   ALTER TABLE ONLY public.workers_tasks ALTER COLUMN id SET DEFAULT nextval('public.workers_tasks_id_seq'::regclass);
 ?   ALTER TABLE public.workers_tasks ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            (          0    57411    location_types 
   TABLE DATA           2   COPY public.location_types (id, name) FROM stdin;
    public          postgres    false    235   �v       *          0    57435    location_types_tasks 
   TABLE DATA           R   COPY public.location_types_tasks (id, task_type_id, location_type_id) FROM stdin;
    public          postgres    false    237   Xw                 0    25144 	   locations 
   TABLE DATA           w   COPY public.locations (id, default_accessible, location_type, longitude, latitude, name, description, art) FROM stdin;
    public          postgres    false    225   �w       ,          0    57474    locations_resources 
   TABLE DATA           K   COPY public.locations_resources (id, location_id, resource_id) FROM stdin;
    public          postgres    false    239   �`                0    25122 	   resources 
   TABLE DATA           -   COPY public.resources (id, name) FROM stdin;
    public          postgres    false    221   �`      "          0    49181 
   task_types 
   TABLE DATA           .   COPY public.task_types (id, name) FROM stdin;
    public          postgres    false    229   Ea      $          0    49188    task_types_resources 
   TABLE DATA           M   COPY public.task_types_resources (id, task_type_id, resource_id) FROM stdin;
    public          postgres    false    231   �a                0    25112    users 
   TABLE DATA           J   COPY public.users (id, username, email, password, created_at) FROM stdin;
    public          postgres    false    219   �a                 0    25154    users_locations 
   TABLE DATA           X   COPY public.users_locations (id, user_id, location_id, named, worker_count) FROM stdin;
    public          postgres    false    227   b                0    25129    workers 
   TABLE DATA           �   COPY public.workers (id, religion, age, name, created_at, work_status, injured, strength, intelligence, faith, user_locations_id, travel_speed, work_speed, stamina, max_stamina) FROM stdin;
    public          postgres    false    223   Ib      &          0    57375    workers_tasks 
   TABLE DATA           �   COPY public.workers_tasks (id, task_type_id, location_id, worker_id, start_time, end_time, start_longitude, start_latitude, end_longitude, end_latitude, is_ongoing) FROM stdin;
    public          postgres    false    233   �b      @           0    0    location_types_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.location_types_id_seq', 8, true);
          public          postgres    false    234            A           0    0    location_types_tasks_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.location_types_tasks_id_seq', 5, true);
          public          postgres    false    236            B           0    0    locations_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.locations_id_seq', 3340, true);
          public          postgres    false    224            C           0    0    locations_resources_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.locations_resources_id_seq', 1, false);
          public          postgres    false    238            D           0    0    resources_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.resources_id_seq', 9, true);
          public          postgres    false    220            E           0    0    task_type_resource_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.task_type_resource_id_seq', 4, true);
          public          postgres    false    230            F           0    0    task_types_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.task_types_id_seq', 5, true);
          public          postgres    false    228            G           0    0    user_locations_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.user_locations_id_seq', 54, true);
          public          postgres    false    226            H           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    218            I           0    0    workers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.workers_id_seq', 3, true);
          public          postgres    false    222            J           0    0    workers_tasks_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.workers_tasks_id_seq', 1, false);
          public          postgres    false    232            w           2606    57416 "   location_types location_types_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.location_types
    ADD CONSTRAINT location_types_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.location_types DROP CONSTRAINT location_types_pkey;
       public            postgres    false    235            y           2606    57440 .   location_types_tasks location_types_tasks_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.location_types_tasks DROP CONSTRAINT location_types_tasks_pkey;
       public            postgres    false    237            m           2606    25152    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    225            {           2606    57479 ,   locations_resources locations_resources_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.locations_resources DROP CONSTRAINT locations_resources_pkey;
       public            postgres    false    239            i           2606    25127    resources resources_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.resources DROP CONSTRAINT resources_pkey;
       public            postgres    false    221            s           2606    49193 ,   task_types_resources task_type_resource_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.task_types_resources DROP CONSTRAINT task_type_resource_pkey;
       public            postgres    false    231            q           2606    49186    task_types task_types_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.task_types
    ADD CONSTRAINT task_types_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.task_types DROP CONSTRAINT task_types_pkey;
       public            postgres    false    229            o           2606    25159 #   users_locations user_locations_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.users_locations DROP CONSTRAINT user_locations_pkey;
       public            postgres    false    227            e           2606    25120    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    219            g           2606    25118    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    219            k           2606    25137    workers workers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.workers DROP CONSTRAINT workers_pkey;
       public            postgres    false    223            u           2606    57380     workers_tasks workers_tasks_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.workers_tasks DROP CONSTRAINT workers_tasks_pkey;
       public            postgres    false    233            �           2606    57451 ?   location_types_tasks location_types_tasks_location_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_location_type_id_fkey FOREIGN KEY (location_type_id) REFERENCES public.location_types(id);
 i   ALTER TABLE ONLY public.location_types_tasks DROP CONSTRAINT location_types_tasks_location_type_id_fkey;
       public          postgres    false    4727    235    237            �           2606    57441 ;   location_types_tasks location_types_tasks_task_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.location_types(id);
 e   ALTER TABLE ONLY public.location_types_tasks DROP CONSTRAINT location_types_tasks_task_type_id_fkey;
       public          postgres    false    237    4727    235            �           2606    57480 8   locations_resources locations_resources_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 b   ALTER TABLE ONLY public.locations_resources DROP CONSTRAINT locations_resources_location_id_fkey;
       public          postgres    false    225    239    4717            �           2606    57485 8   locations_resources locations_resources_resource_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);
 b   ALTER TABLE ONLY public.locations_resources DROP CONSTRAINT locations_resources_resource_id_fkey;
       public          postgres    false    4713    221    239                       2606    49199 8   task_types_resources task_type_resource_resource_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);
 b   ALTER TABLE ONLY public.task_types_resources DROP CONSTRAINT task_type_resource_resource_id_fkey;
       public          postgres    false    4713    231    221            �           2606    49194 9   task_types_resources task_type_resource_task_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_types(id);
 c   ALTER TABLE ONLY public.task_types_resources DROP CONSTRAINT task_type_resource_task_type_id_fkey;
       public          postgres    false    4721    229    231            }           2606    25165 /   users_locations user_locations_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 Y   ALTER TABLE ONLY public.users_locations DROP CONSTRAINT user_locations_location_id_fkey;
       public          postgres    false    225    4717    227            ~           2606    25160 +   users_locations user_locations_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 U   ALTER TABLE ONLY public.users_locations DROP CONSTRAINT user_locations_user_id_fkey;
       public          postgres    false    4711    219    227            �           2606    57386 ,   workers_tasks workers_tasks_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 V   ALTER TABLE ONLY public.workers_tasks DROP CONSTRAINT workers_tasks_location_id_fkey;
       public          postgres    false    4717    233    225            �           2606    57381 -   workers_tasks workers_tasks_task_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_types(id);
 W   ALTER TABLE ONLY public.workers_tasks DROP CONSTRAINT workers_tasks_task_type_id_fkey;
       public          postgres    false    229    233    4721            �           2606    57391 *   workers_tasks workers_tasks_worker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);
 T   ALTER TABLE ONLY public.workers_tasks DROP CONSTRAINT workers_tasks_worker_id_fkey;
       public          postgres    false    223    233    4715            |           2606    40989 &   workers workers_user_locations_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_user_locations_id_fkey FOREIGN KEY (user_locations_id) REFERENCES public.users_locations(id);
 P   ALTER TABLE ONLY public.workers DROP CONSTRAINT workers_user_locations_id_fkey;
       public          postgres    false    223    4719    227            (   J   x��[
� ��{�n1�T�:���z�iqh��!j�p�E8���qĕ�p��;h��K���[~�kC����      *   %   x�3�4�4�2�&\�@Ҕ��lSN#N#�=... L�9            x����vǶ-�F}z���wD��lɢ(�"�m�S7H��$�@J����\	3"wUk��=g螽�p"�9לjq\�u��2i����>������E^n���.��,���i�����w�z�^>�m��>�"�w���~Y��먃[��Z���#��Y���w���,t\{�x�n7�`1��}ʬ�_h�Vf�f����~��^>O�c�_�Һ	���6K�ѿ|�n�)�Pv풋�˼ﶒ=eI�����Qk��_\o�oD��]te��c+�N�׹_^�q+�@�|�_��0a��+�~�
VS��7�D'M�H�c��e�Ow�/_�,��]i�lL�n���W�$?\�<�U0�mZ؆�5����~x����zR�61&���MZ��Ћ��X=!�6�n<����8o�/��A���+�qm�Bk:uZ���>f��P�5��&K��~��nqN7���fyG�$�<��Ͽ޴�����U_]v��;G_�����o�%_���цF��k���?�}X�uC{�X��'eha�~m�Ϳ��h���D�=�BV�e����[ѫ�/O�Zl��,�E��i���D��4fzL�Jy��dU[���Й�fM�/ޒ]�t��n��(�owk����H��=�^����~��0z�/^ѽ��8O�򠜚�����M���5�פ��(�Օ]M^t��&D?��'KqCCg�������]��o���Y~��b�F�D���t��׽�5U�����N_{��?����ռ<�@�i酒�s�b��y#{��/���.t"�O�զ�?�-s&��a���k���_O&[-����ڭ�����rYo&R�g���}yT�f�p��\CN�}���E'����8:zKI�tq��N��˓��4�ۭUC���n�,��%Λ�2⒆��k:��QtC��;
q
rUXr������o�d��h9z����~q��=<�E�`�\�A�D>��;�����LLc=l�K��7���=
r4eC&/Ű����Yt�myA��(�.D��|+�����e8�t����� ��%�3���}�d�>P��,:�8�FѲA&�wC^����S2t`+z�&��{zA���tM}����Ԙ�'g�Σ,CV���vQ;�L�x��Ҥ��3(�jp��ʆ���6/ߏ��q�,lf>P�OGO{ko��'�lm<)�	�:��F���#
����}��w=ݦ}{��u�!EJG"�w�G�(�I���K�&��殉�%¤�UO�Ί�1�x��k�'��%urId�zQ��#39`��N7fq5�%Wɫ�rF�o����?�Bk�KLG>Ђl8鵟mv���czS��	�: T>�zQ6��#�/�:*����o��yD��u��Yy�V��l�k�%y'Y���	9d"�n��G�r�>xOO���Tu��%���*k2�Ƒ3Z^���L�s$7S(BѼܹ��Gd)IV��'?v��~#YR��I����kEN�
������l\���R2Q�iş�1:��0��8��J��͸���(n/�)���#���|<����Wǋ��3^Q�c�L_���EqS����r� �LYr�h�:dO?���#��STv�}�$�9����k��26��'�[��HVM��:�b��c����V/��A���a��e�\�ܒ���>�iۧ^���o�hQ��Uh4ߦ�d��-�u����K5��!K�}���L��М�������ƨ�چ�=��|?t�_����Г���D�u�6�"?C�4�v�4�ׁ�����8��$�7�ӵ��,�;T�J�n��.���\�T�!���|�5���$���⒒C!ԡ"J���(*%])R�d�V���KMR�y��E
o��m���*£K��!Q��y�T^P���S�@�2$�q��6K�`i֗5�n&�g��Y�FG/�i���RrŞr�O�VTYJ/���M���9�d�T�r���l,���Fi�����r�4K�1�����iS�t�9�6���M�����iӉ���o&E�v��R\{5��be����l<m�U�^��(ۅ��OE��-�����IvܔG�u+^�j%����MF$"��hI������n��zﺽȒ��tg�ԕ���(������˫2�6�'�h�H��Ё[�?R�o�.'yJnY�7c�'�%�ﭠt���l�(]O�)�i:��,lM)e���t\	%��Y�Tu�H���w����:K�~�:Ѝ7�x���t���=���x�
�a��Z=��%ٔvZ���]������>���m?t��o�>�ל�o���\eNO����R2���nfk�{$S��҇{я�U�Dy��&K�6mgx�  (��+A�($�H���XR�*ڵ����8;n�^�)�)o8�C��|ؠh"�Z7\��RBjLDɠ?
�K ��-W�],�!�w��,�̒�۴"����v{ۏ��V����g�=�t>uw�Q��՛��)X����^��zT����Ԕle��߲�_�ÊB`X`A�Z��v�_�k��{�S�J;J	?�����)������e��%�r�W�R:q�QU���:����O}yQdGc�WK�UQx�m��\`�E�*��5�Qu��t_Z�Q�!�qDLp�|����P��x�,5g�[t�E�`AB�K	��Z���"�����^����׎�lzU�Fq�S(�:��K��,^�vy�]�����������}y\��Z)��g����ϒn�� MZ[t1-ڄ~�G+MZ搈F�]	�eRC]A"���m���}�`e'����N�1`(P��Fiu_U��S5� �T2�(�>�~��U�<� �ҧ�Vf�j`�8&��S��6��V�ƺ#��k?���A����·hkS�&^�J��:4��6��]�{aY�Y+�8��r�nŧNj�]U��`�bJ�0*��DR��oJ�*�_|?
#�Aߧ6'�0�	�:
Z�Y�I����e+>��� ��;v����o�wV0	�@T�ݏ$�����C)�ҽR�<j/,ϫ��G�JJ���N\RD�܈K<�b����ʟ���4�f�/;
���y�P$�pwd^.����3%zS�Y'�D��X��R�H�"�g��dM�I��]~�h�`d��5 Ċ^��v�*�
���}�� ޶�[�
3�z��
��x>lF٢� ��z����Ǽme�0k�����\�� rf�!G����w�^�]��Ѧ@��E�wdKU�$�+��(�㊇xf�N�`s�ѧ~ߌB�R�%��k������@�z+zYV�~:=2��
����M��Xց��l
�'���M��D˪ڲb~P� ,��j�*�#�B��|�vP���䬆L�I����������~1A�c2���	�$g���RGW�v�{~;F�������T�vo䙇��A�y
�����l�AU���|���J����x7�
�)Q IW�'JN�������JHu��%;��iiR�����:��E}��Ӑj�p��I�BN�A�=J�#y/,�8A1�m��b|�<��<3ӂ�k����ʧ�ћ���0q�j[��<��,�zQ|��ty�O\���9�5�6��"ڶ�^��RB�{J������8��Ҧ�Y���o;�-�㗕dtSMR2���b�0�-� ����,&S�@����fѬo3�K�D�]�&X#������R
	C���:i�S73'e��@^�ǌ��;+E���r��#��y炣HY�������^6�����E�L�q�$��Y�/N��:5d����M����% �x%���j榴U<S�Q zG���QĶ�f?;�Q��P4�O-�^`8jGI{���6�[Ѹ{AS�	9@�����,�TJ�
t?���W�@�,�UѰw���7���q�E��f�(�8�E���Ъ+� ������|<�r텉|$�w~�o6��5Uh�����F� ����`%<Gȃ#�t�}��AD?�gY�b[G�N�ĽR�g�� �e$�,r�g�/(6k��0
��ǻǽ�$D��K    S�6�+���و@�Z����o����:�?���Ý����L���E�]��y�(£��p����	 ��QF�+�X"�.Yz��Q�efS�������~~N��YS�G��o�|L��g��2oFi�E�Y}�Lã�a9�H�V��s��69zt��?���:��OEH��Ө��1��C@`�1�#;�@���p��q������-/�W4�W��M���'{���{0�&D��#l��2���M���<J�R
����BH���~���`�9YOO�Z��!�Ϲ;�pNW�	�����>�n����U��B뀂*P����}�sJ���}+��#��f��ȼTx1�����;�}�e\S|!s/5l"ס`�8U��� �y�9(���M�w��h;5�T���R���cR<큑𜈩���t������8�/�	���C1KB |F{/
-]�G�/�'po4�`!zݵ�Ac]@tD����8����<�VtM݌�� 1�ZY��7��"��f�ن{��R2��ޤjb��ci��V��/��c��+����_��E���i25�'���rw�/\^��S�U[������Di�o�#`P���X��XUsM�l��[#,>v�72{�g�TFTpjn���~���}-@
Jr�`~��_Y�1ݽ�0�`a#(1
sC��c��U=���:D����h=?3�6�(f�$G�����c����I�v���Rw8J)����6"��g���!p��骡�,��a6�h�ď�������5�
R�1��8&������d��@*Pr��0O��8Ȉ�b���L��4����~��~+"��P��'�BӚ��nu�E��FS4x�CoZ�os'�R�
JA� �΍�n;�������aP\�J��!A��ǉ�x�<�ra���*�Z/ȡ؉�A�q�܋��t���\
S��M�=�nk�U�]���:�BAg��i�,s�	��� )V��#��+� �~>P޽�:�
L�'#�A�_w�� CS�8�ϒ-]!^\RT%<��'��|�L����x|�B�f��)F�-H�@ �;�
I���#��>�;�+��'@�m㽼kz�?n�ET�(4Ɔ&$�'{z��͡�i6�H�!���8�Qv��|��h�`8}��k,EZ'g4o,zW��Y�4�r��d�o�NآJUZ��v@%XcdB��,E$�gМ&�oS�����T��z��>��x��Eg��*;���=	_iR��W�^�o�w?Dͬ�k@�M/*DP�Q��M��5���5;�xI:0ij
I�[Q<���>��N�0s�h�5h�w��yS�QКj��:ũ���z�h��X0�ۉp�f��h������@��_��E*�'�n ��2�]��T 
��T�\���N2|f�
�X�g���Vv?+����?���w���I��Ԭ���f�Fm,EO���1o
zI�����ˇ�QD��f�*�v�Y���GG�L-���A�.��3]҆�Q�H/�K���@��F��ڇ6��aS���߈X�+����=X=������ʆ�M�h08iѢ��D�5S�((,� )*}S>�����AY�� ����x%���2ۉ3�BoG�0�ѳ��4�5a��}'15�Ӗ�G{(g�SΝl
��&��AO4=o�oæ=l$�)p�����I��n��eq��kn���#`���{��SM�8�,6��;!ጩh&@�l��r(nx
�eS�m�E�s���;��[�E2sP�ዤ��Y{��� 
E�"E<�=�����fBÕ�����-�Tͨi�
���2�_�L1I?>�S�7A�L{����܏{Q��:���[�k�J��e�R3�RDx�/�v��`M�S@^�3�$�(��2�)(
���$��V벽�MAP�0�`�h�����,�3vV��ZI�ixrI)�� �a�C֘i�a�e;�:�>���l��l���l����JB��n��m� ��?��{�Y���%��)�	J�Hv��	�'B�T�'�%Ja�e��C�6������擳 zy�B�D�U���<(�M�n�C�M�Y8�ѳ�;Y��V�А�z^�çq�Yd�+�e��,�/����BF�o*n	 �Qˣ����:����զyh�n��Nl2n&]c��ƅ(60L�p�I����'^��;�fS��0B%�P�0:
.�K�
"��I̖2�V�b�C'���|��d*��}� �(��2O�2�7����NV��s�ͣ���~��ƛ���(�i�:��4ڏ��^@6���+�˧���E�o��~~I������ܓ�䒢�؂�md������q�e���S �)�v8*a������z�.~'��?k�ƉWp�`��Y�O�ˑ�������*�	��0X�t�
��8��	�Gy��������8�ǀ�������N���n'a����v�k�5�4��P���>I�L�5p1j��ߋ$3L�ED��xR����S1��
���\z���wШ�Ykz?��=`?>gaQA"7-�������=v;�Re-ā��z ���?� �ITJx�qzPȡ_罐Z��:�[OZ�X�ߺ�m�ƻq��#d)ڏ�.��^��3��(���|�}�9�8S�;E8�܏���9��kX=�8��?�\��"h�:���G��ߒ���8S�����������&Q�E n�����]����(�Mu��0_��'�z�����U�}p-��':���1j�$R�66"�U�h� ����q�o% FSc#@��ex��Fi�0���Cb�U鑜���6GF0�����Է��T�T*�����ɖW�p�ˊi&.�aT`�h<��I8�dj�	�
��SC�_�r�WH!�&�F�c{�IY6n
PcCf�����[ޒ�Q�ئ
Y��I�]���E�(�2�Vy/�ٶ��h�{�,���j���'9E�ʰn��,�l3��:�O��B��
k�
���-�8���y+��lI�]:�����{��- ��o��@��:tI�)��f�7r@lӎ��3�����R_m�a>K95��!��DW�@%b��U���Q4sok�:�ϵ^� #�-@��Dq�pSǘ��&?��^�jN1�4�hM�vw���cm� �*�����D�@\afԱ���)��T�l�LPJA�2k0�?=�.ռ�ל��P[�龌BkU�%�Gӿĭ�W��leZӶ�%���6�Q��9��$F�(��H�N�f�/�M�j[p����lO#�..��}-Y����St�r�$|��߃h+N"�/a&���d���mJ(�?9�`���:��D��$V��y�舯FC�n���_ق�p���)�en���`���/F�Y�H�%$�(�J�����@����.ۧ�N�h	�<zG8*:���.��R[ ��0 YD1��x8��]�̀|��Д��>����"� &V&@Ģ��Or��h� & s 4؈��C��YfP
^"�	M�
l,hGn6��-p�U�gj�ȅ.~����.�oʗ��tpך�sҨ�C�/�PTXC�0`L���A�r9n���,!�&NXǊ@�lM�_�K���(�N˷y��G�0���'������w���o+U=Qjc����Qؑ�^B�k�P��5��?�p��"�?T��2���qJkg�8X͢�?����]%��`��L��l���	K>�a!9�k���$!�\�32�wB�\0������gт'� Z�����|�?��#m�I`'
,����N���$x8-�p$�܎��,��J�~� h|�lAH� nV���؉jo��c�h�FM��� �p5��'�
�@��d�.��&Z����:�&I��>���@�� g����"ZWa�p�'-p#���u"%%r[�#����Z��~>�����n+�y�"�# �,Ai���� H��Lj+��lK��u�����(�Ͱ��������7�(P�H�x���D�ܡ����!��    ����Э^m�~��lM8��Ћ�Pz�
���,�#
lb�<䨡���UXA�kwߊ.r����f�E��z��a8[�J`���Ki�0�o�Q ����B���P�zEG����(���"��^�.P����(P����_�4��D+��*���,'�?Ȅnڇ�{�[�ؾ-@
�#��#�c �U�
�I�� �P���ūm����&*�����T�3�^�0K��c��Z<� [��
�#S(Wi�U�R0,2��BAD��X��@��U�Ϗ���p&Z�+O^!ܵݝ,��34z
'b�Wy��wYL-d����A� ��`�"�+E�"cgLHBC�nb��Il�RDzX��Ň�k�n�AVR-���Z7J E��6d�qg�-�ԛG ���e�fL��������F�;h�%e7	KQ$��1b���!�c'����	��b�dNP>���A��
�"R��8B��?�/�M�%2I�JS�,K�>�\�N"�4k���NWs��|���M�ۀg<y���@@t
��������=�Z��Ch>N#C#{��{f��˳��Le�@�\��������q�*:������DY�.H
(?sOi©|�p�d�`�Ӌ�:�m߶��7�
��� ��1�n�6����;��b�������ATss$E�	�A���2m���@��Advx��ۡ���⥐�ة��|�w�M{/�U���T�"��^2<YF9�
�z�UFJ���"s�*,�*�<z ?PpqJQ��,�j1�q5��� k}�f�����?]�+2��[��s��wƼ08-ˇ�(����
@С����hO��9�bZ� Bn W��4���uB�����Y�6͜+�?��&�t�����Wfpp��ٝ�?��o��b��n^Xw�^-�O�4�C'��q�������8B*K��v�1�(\��4J�.n�9������)�ѹ��@1�h�:�WL���IW�>Z�C�,>���n��ݸm�S��x4	��� ,]�豫`��@��Y���'&[��yF����d ���_]�;�ͪ�<��%�u���]�Y��L R���}ȇN��:]�`2:	7��sW�~z�~�����A�gpK�N)�$��|�ɲ8��)Vx���O��I�J+�f�2�_d修"���U�x�A�KT]�Qx�|�-px��U?���H~/�83�lN�=����� ��S ��S71�L��U`
�'���Cg���^�orLa�|鑟�@�{�;Оދ0��������y��Ђ��H��r"=wQQ�s���,���N��(�~b�:�ꨮ��ܳ�@r�{7<t�./��,�os��u	k�6J��N�u~�������
{ت7=�)2�j+�J�_V!|��ö?e�;��3�\����Q�1�
��E0�M���Y,.�Ý���
g��$����E���(mr+q��v/�s5��1����oĴ���, �'�,f�~�Cw/�zpoa���� ��D�YW`���ދ͸�8��J*�.y�p��9�o3�h��ZR�O��Q0v�0�($Avj��y���u@��"?�qt��@�i�.�vy������?��u�E��T��	 ���`�;0W�0>6X����]?I�'���<�.L������!���e�-�kjL�PEJ��{�wQ/�U�P�vL����O��K�*.
0�/qn�1���j��� ��8_�R	��c*��m��n/+(U�HДE����WC~E��* "���`r��hyQ�B[h�ƿ�ƻGa�Uh�� �NH����V�EmTWu@IGqE̓���FZ���C�
ٹ��12c]�R�ª��ר)	�]���P���jИ��1��ٶ}��]����r�E!ǉ0Qv�BUR���]U�T:�Ð� �u�\V@a��	Ps<�.��aȢ���U�B3���"1�&Z�<1�,�6b��T׹;�zt� +0�&��!k@��7c��F4�*�x.;�����Ѳ��_S`	l���;J��L��,�ƙ�@�؜[�&��Sƒ뢙/���?͞� �/
�b��ܤ�*Y�qVA�5�0Y��me���BT��ρ=*����Ȭ$�ʂD��)h�r߿ݶ��B��p��1� ���1w�w�K�@�/1_"��+@�h�#e�cY�8Kź\EKJ��Jv׳�v�eo�R0�T���[�������t)�4!yB�W���}nyO� RqV!ox5� ��_�;��E�����Gz�R��K�j`TG���ݪ�֘�YE�Ͼ�wc�m�
MY��%^��ъ�d?-�����m��Sl%���ͬ_*����,�,|�S@�u�$�伯�o���
Oѐ�G�^�Y��ATW�K�� 3�>�U�.����+b
TA�����Gq?�7�R��Y@q4)����@*��p�;㭌*�W�	��		eH���4#��PE����,S?�sՎ�.+��X�D��w����v9���=�,|�Q0�\!�mȰ��w@���(��j�qy�Ց)	�o����ݤ���L���E�B�N���$�22UX���lx�X�u���[U��5�j�ajJ�?P2�����Kj �FUx����
\�(��5#NJ |[�`��w���!T��PC5ޑ���f#��R��M���N��|�v+��|%��$�hPU�?��o�n��s�& :^�OU�(@qL�(���Q�{]����P��=r���D��g0��d@pN������<*�Ӻ��_��QF��u�V�C s���y�wO�^ġ�+]H�r#$��V�V�B�ϓ���Z�-V��4�x\n?пnq�c�V�_
�t��c�sʍ>�/�3��"oP�+�&<Xx[���Ew��+`R�nA��[/�*�~ iZZ;��[��,�ΗW�j�3�)���e�:�b�Cʀ��q�)>K3_0�RS�J���w�ȄƼ�J~�W'�����6�����"�OG��Ѡ#����奨���b�~���L�0dQI���OQj��ޏ������+h6F�m
��W����[!����vu�v̻�v��\�CQ�������*ҊH1 mym��]ޢ�*b��W%3��u5q/������`P�<�h0Uz��*z�T��DHkO��כ��#��h�T�U<Rz�2a7C�apɢu��'��\iq=t(R��W�U�)Z�1SA1�r#�M�Z�f�YPb�ӄ����+�- X��FL�	����_�D�
��U��w�I�h5N�E��4 �:.���V�T����d���S��ם�V�Bam�]���=v"2)_0L(pj:�֨�\睌��׈
����|���L�0��!n�yV��9��@�{�)a{_!��X�[=:(~�۶qnx?k� 29�(��>�9�"5��I#hpȫ�z��BwZd,^o Z���Hd�$L��b=/���午	�hE8��)�<��x?g�cJ�F%��ȝ���^U3MTpC`���E�T�WۀP�!5Z����=S�0k��ª� �O��|��ug���Mb�Vk��V-+\�\a5��n��_1-EzI
x`�ѝA�|AS��V�T��}'f'�K�_���L0���&he�:��ӵ��'S-��a����F�(
*GY���(0��g��R����M���YI����2��2?���O�O�.���t@�������3�P'S}�����n�3����])�'��qt,H�'�$���q67�6��l�I�1� H��Pq�a����~'d��q���=W\D���A$8�+.
�١Kf���a�؊����v�fȢo�m'�w�Db�z��7㷼�q'��p,��;M��?�]�D���6�NnEE��@;�_:��巼�.�BS_#�-G��k�˷��Y��Gn�/Āꈗ�?ݝln�Wx	B������SE�L�����Q���k@��=�W��+�~sU&����d���B>�U=�,�a����~�l�:T���    �Nk�&��u�JAh��Z�Ǝ����,r��G �ցٶP�x���С��9�15��; c�@\e3
���J0�E���>���P�K�|(8	:s݀�2���e�(��'ӁAI@���� ���H�A��ň L\���p*�i�2���Y�ǆf���	Ņ��O�*����(�*���N��I�!l@y��{�ۿ������6�8�S��4�<�~̏w��(������q��҈������#Բ�s7��M�	��x'0"'.�iS�!CއX�Ah�}�����W��*�����@�����#+vL�;��r���H�,��*NPi~Um��*T;��>�/��VZ�BGhy�U��o��"�PPP"�X��j��=�7х��hb<3������h�C�� �$e(
���V���u_I��)\,T8	��VR�N^CF��g�X)�0L^J�y�\��c�����O)�:Ԝ`���7hJ�����$j�D�R�6��L�£*���y��C�7z/͝C�G R��e\a�~�~�~��Zq΢�D�Q��=����q��;�z/���=ef�{Z0(f)q��g�%"I�P`��!��V;H���HD��c@��|j��TyU9@�QsXe�I���J��S1�Ò���V��
NM�Es"�h>�.��f��P�m��y�G)�S�UO7���,	
$���i#�!+��l �"�y��{�|k((	�KN:.����<xP2S��� {�EE�P�\L ���������5=��l��@�4�$�CGD�� w7G~�i|ng��j�G�1�|vؠ�.��kƉSmN���G�@\p��nܡX� 7�	��� ����D��w�E�Pi{���Da��CG����
*¨���Ҕ�]o��!/�vy���;�<T 	X��4�^��#��}��3�$'s���J��B�G�@=B�:e�z/�=��D���H=���aNPd��o���)-@4v�9l�N�l	n6�� s eP� %*����@�!��~q���G��\�5]�Hi ��h]�C��Y�?��G3T�zs�޷"j(@	L�g:yP�c��&����s��Q�b6?��,[Yp0����Rr!]�*8<�RO����S��L��:TQ)��K<�*� �ɱC��O��ʮ���K�Z˭Α�K��)`	�3JR��E�Q�HLcB<������U��8!�P�3�(��oe˖A^=���&�u��yuF���H4�D@��MtV���n��؊q"��d�o�����6oz9�h(P�U��'�����p��QBkj��#���?0z�|��tq����z8��/ pƠv����VT�)�	c���#�|�m��&ZV�1 �o����p\�qu5t{Ѥx���TW����h��, � �l���le�:VÈ
F5L�[�����k53�ȨR<�LZ1W�#Ђ��.T���k�@��C>�"���@ْB!s���C"�`��(���q{����S}a=��� 4�-����H�M�\�Q��\��q��Tu�
� NK9�(n�VH
r�������{����Ht5���\`�GHBg
��%Wi�͛���v�I�
E�4Π�S	��m�U�*��8�h�c	�!?�"�ѐf�Hȅ��[�joG�7��&h?���P{ߏ�A:�
��G�� ��j{B�cS��Xa�y���v��(ӛ�S���qP��@�_�VD�kމ�@��9M�Y�:63�9�G�1�Ml*�Y
,��kZ�7��d���`*(D'�� �xl�,�����ECÜ��yh�c�M��K��'2�d�K��9q��AD��� �ɺi�}�l܋ࣱ���1��^��]f?�$�]��(<�7d��V��jF��O`N�l�w'�Ob�U`�:M B핋v��=4�D�V�̣ӧ*Ȥ�܊)����J���
Z!����c���m��Ъ ����n&��;D��.��㱠-0�!�f1�B�����su�c�[��d&�$o� #Z�#���T�qs�i�<ۊ��Q����q���U�?
7U�ɘ��@<�\��o�0��ea�H)Pn�� Bl��^�G�b��[�kJozhw�Z��-��D�y�k��e�tQ�m�I4�M���؏��J9E�A�
������V�w����_���p+N��dO�'}��f�P'z#T��e�?/�c~|2Ƃ�X����/�98{�phre"Dx,�n�b+ ���C�m��m��V���am�83���t��H����J�o�H)�i ��@99�����;QR͜����=�h�c%�Av���"�P�ϖ	hƂ�@���[L�\d�aE�L�Г�gX[�!��q���hL���ٿ��B�n�?��l4U%í9S������|a���ATi�Ɂ��"�`� `m,#�����_!/�=�(��O�/����rL/�k�J$QTK���h-��$�YT��+�
�80�<�a)0؉�AEYA�G�F���m� g�0�+���B.�h+_6�e8
��h��Ί.0�)���[;��Pb���`W�V?ٙ��[If�2ce��RSS꼿�W��~��FDD<
��vv�|�w;���+$��&K~�*��
�&FU�:$v�}{�9�̀�1��:�	:;lv2_SPX����✏2͞�f�:&� ^�'�J�L�����E�-�����E4C�a��9ʓ�-� �bV7 J̰A��ܛ~'L@$���������.˰��� �^�`!���-8.���|��O�"�]�� B���D����O�.2��8F����ӡ�?�2C]�� � 8�@��T�(Vj ��)YK�6���D��@1(����B��۶E�諚<�5�cqqpﾢ�&<��n�4�"�p錂"
4Eϩ��4��Be(+x�b�Sԑ�a6�����&�1=H�1�
;E`0(~�oE-�XWP�PJ�!`�0@�Ke[c�煑	N��
ry7��A�q��aYY�O�<C������@�,+��G���?���|��("�i.�
��F7x�
�V�]
2�hV)��
o�a|v(
6�V�Zk��o��!�Ϋ�2,��I3|J��=��_݋lVTu��(�oP<�6��b�����>�}����ǀ��^���!�j��,�h�A�Kz�����
՛�x|f8��j��,���oQ(�D��_����W<MB�����[����׸�����;��x����0��"�y�������
��Un�x�����
�AfS��b�~y�E0����Ò]�i��ʲ�-USĔ_����JʳA�'��h��<�`�&�e���c�f�j�~��c�Ev:%`RVoF?�6�5�@�Ϯ�Mh��~��UO��mމ�H1U��P��LJh`��~���@û�I��x�<�d���!w��?�	J^�����R�̂�^�(1�� ���b� ��U�7��"=��̄�$�	�����jʋ���p}�	�7m/T�O�AQ�fp����&߉�K����L
��Ե��$53Ѫ	�& �[Q���"��W�Q� ����
#㠶��<{E��T�wd=�l�AԼKz�*ib����O�m'�\������Y��"7��TS�����_���<d\*�Tzl�:e?�PXs'�̪t��	\��W���eKIb�;��ɛQz��Р�&����x'�k��T��N�ٿne

��+0j<�A��v�k������-%9��Ȃ�|,�����p+JER�X�͏�Up��|3Қ�a�M�
cAVIc х��?e`ҳy�d���h⦗�����:� ����]���U{8�X�REg���f0&��n/�u�
^��)�� �a�n�c��f�0�87�-e�pd^��M���o:)��S��bYjaj�:S�>��>�F�R�l�X��?�B ^��Pu���N5TQ~�e ;U    ���o�i��n���5?t�m�^�1�J��6M�N�$nK��R�N	 J�R��,j�$S��YG���'�����}����Əh���2)��0�o���dfZUMJS� ����lf:�U ��@��o\\	3���Sf	�D�#20o*�
:-�W�V������2w�u!�3}4'ϨĎ�.��v�BVЏg9� v7M���z��� >���K�Q���g^�4�@@9)^�8)��)�o����c/!POr=L ���ƫ|��9R�O ��AF۬��hC�?o�}�(��@��(��2:�����Q���dA�A�����N�hAR�8E���>���wQ�W�	.��R���坨�
vb�"�>3�h��/�ζ[Q�'��apRf9o�V:Г*��� '�'���Y��J��Qs������d�+%Z�<.�h前�r.���uШ�:C&y�u�iAf�m�{:[Qc:��]��%� �@��}��K:��� ���S �xK��.�ࢢ�P� �Z����W}�?��}'+���V��L W-`� �3�3�V�J�:����lDЧT��6�N�<#���f��ꓟ�2r������(Z���J����#%qܦ����d�X/\�~'��L�"ǥ������y�����Ba��˲@��ՏҨ�`)�Li��~�����j�zPd��0��[^��^D�*HD��ŀ	���x��.s�35���Gi�U��$�L�Q���K���P��(��1�>�ȋ~���P��<m�DGn�l{;�M���h�*.'��4�V����R*(
d� g`QP��4|�Qd +�P&w��b�����ފ�|y\���П=�.��ٳ����k�ѻ�����"�[�DA<S�Q�e)\=vYv������4t��!�5g����q+5q��:���P���p�� �:ϛ�-oe �TZ����+���J,{a V:U�vV�rQ��Q4�
ls@ʒ���[�����ﻧV�D�L^GO� ��7C��.��q���3D(j���*����z��'~���M+�fMA7�"m��z��Ԏ�}�
~b��T��}��2�4�1��x7f!��j%:�J"�kt�/u����z��ܧ
K���9���4#�e]F�+J1�-�4��[��U� �{/��N��=Y��z�F�Qi���T_���pJ�~=�գ$��Ь<-�+��A�P���|�,��iٙ�6],��5Ф�n����7 geB�it���=�C���C>�	?�T&q��R'����yZZ�Ƭ+ "�z@P~5��~o��`+��h 6kK���s�{��f�ʊ1��H��P�p�.�S��?lZ�D5���.	���~+�Ҋ3v��L�I�������E���)���OFL��$d�VE� ���Q��{���,�GJ1�֤ů�wϭ�3ҲU�|�8��B�rը�iE�q��
>�u[Q�����sjH�X�s��6��흴ZNK��Y�a愆�#�݉
�)`4����tC�����=05���`#�l�z�%s�l�ko��0�9l��,b?U��Z�:��	$�7�VۥE_^��f�N�¿��[�I�jd�=�a+$�xj��]���c�5�g2�+
 �]���^SΤ��Q\���K�HAs��T4�jA��a9US�20��p������B�P�2��p�k#�������-\���W\�Hh�g!;�j*�F���j�"ک�^��;�"t<����K�,Z�����1'Z+V�PM�t�0�q�72j��v@ϊ�����QQ	R5,Üy9
g��z��\����3n0�qE	�БՌf:)��Wp
��Q՘Y��y�/��Eh$Zs��j �B=FGMF����]'�-&�6�~;Y,�����<��pUc�̏����,�\쐭[3_@t�1�E��Z)�u�^0�Ж��<��_;	�V5����'�G(a��t�VT�U�ذ��&�1��{��w��ӣ��Ӏ��#�Ƙ!�QxNB��R�ş���	��0~��g���y��0��Uҥ��M����Q���E�2G�3"#�R��$C���v�l�0r�3�A�j���sZ:ᯚ�@���h�[���(�����~o�hL�j�h��a�}�2<!-[�tA�Jq��!|��X�F�A�WS�;t��\�k�2���*��4@�g��a���am��\�G��:���e����'g`+��k(F����PS�3���}Ȫ��J�$�ɑA真"�?���*-[���Cm9L�H2�&��̐Y2���a'��U����6H��9��w���G���>���7�#��FVb$ә(v`���v�� �Y��uc	R�	�6��}Ȳ�O�Th��؊k≧	�Py9���l��@��X:�G�խ�d��r
k���ڒ�[9601��(�i��L�Q5~VÏ�������8�j*�`�@�pz�`���H� ز�W�c8 QV!O�o��]rcC�pM�&Ll0c�2c�5�(�5�d 5��US ��)�:ȇ��(S�UM�t 'j&2:��]�5��j�M]��[��=a^�@��*;���jB=��p�2�zq���d�7�@z�4��_LY��2�g�8�h�	]v۱�a2����=�Dݎ�����M�Ӓ��}��s�� �y3����d�G��L��b�,��UM�S2�̀KwBJ�y��#[���DZΆ	#�g7|���f��.϶��q�ξw�D��y��qM��юz�e���+�dY�������ˤ�m{�ne(BZ2V�)�jL�HxI�Vfo�x� d2HZ�a���A�ի 	�> e��M�}�ǣ��T2&&���1c쾏���fUF=1ܠ���ԁh�ҍ�С5��i��>��di.𨖁����W[L��-ݲm�e��=����p��>���g�Y�qӬ��g�N A���;�T5�����CU�<l$�\Zs&�OSE��y/"�V�i�Ȣ�;��͓kӺ��8���	F�S�/����(+�(V�K�i>t�;r"~yZ���*�(��腗JU�&��dr��~�o�{р-Z�v���"ાތ2�MF���G�}h�4���?��O����!a�7�c����������(T�V��< A�v�2`@�k�'��U F�_��QTJQ�@������⏡��f�؞R���@>�,	��8�	���<D�&�瀾��ò�[A<�f��ؑџ�BkPl�|� �����kZ���u�x�ۛq�т�@���A�Q��Ђ�XE`�F������z��i�2`<!2s���@��!��1�aⷮ_�Z�B��`���Ъl
|�\ �wœ$?��)]���X����@��*Uu�n(�kX�؋1�dhU!:Ȱ��_v6�,�R���hP���z`�]��^DͲM�&LD.v����*`x���?��c;��p2��r�-d�H}�/�l�>IsCU��`,���P����n��B�"G�{��<e��[��)��ZTAw�U�=1%]RL@���l��V��n8����+�a�Kv-
?�ĉ����U����V�2�>�Ə�J,^a�g�>//����<81�Q��Ig�����(���1E��μ˨@�W���6H�1�sMk��2Ȅ* ���eI�hP��{�vaU�k�&20f�6e���w4��]T������-���#������1�"�[�y<@��<��w���U���\!����P����q+U���\�1偷��{����+�Kd�����0�t��E��d�����	[F��0��	��7��O���'frD�=9��Qh�l��E<�S��;���F�l�ir���p��B�� B�
�,
!&�H�v3�}��a6�y/+}*7�̠�M����ʞ�y�vy��E��o�Q�*;&G5���C��|J�B�[\��N��Tn6�i0Km 7Fy�=[�`?(�a?��g����kaT͐T{P��&�u��e�HU)�(f:�    �K�������jʪ�h�OoF��/�e��L
B�d~!?�U$��TEӁv���5 ��۞b~���Ox���0P;�#���@D�@�l�D�/�nÿ)&�������?Ids(����ж���ɲ�J #�p�|��z�gJ]Pץ)"���H��1}��n(fz��]���9�l�hB0N��/��/��6gE�ܓh�������VB1��9"L�o��֜�E���셺��&/o��T���(�^���j��MHU��
�1���P��]���ܾ�~�_"{o�fĞ�����eRK�<�Qj��3���n/U�J���2\ڤL�b���~��UA���~9�r���}/�P�zn��SJ��ay��;FPU�(�^T�x:e��M}^�"�r�*8H\:v"��I�?�EK�~�����ҒA�U��8g�84\���Ʒ�@��t��P��c�gaӤ A8�e�&]a9�:��m�b�sS�);��*��[�Skm�E�ph��� ��T<`%,�|�S����oU	�h�����F���5���p�aAδ�E�=�*(#��"����Ã����,�|�=>���V�0)�ɶ�@>�*��A�y������W�=(��qB��tζ������UA}D�;��(l<�t[˳R��Xqa��)����9�{i�_ �N�IP@���%��{s�[IzY<Յ�h�f�pJ^���f�DN���8�4Ci�*Vl�BgX�O/�NX��,T�|���D���=�T}i�0����<��>��
��`?"�t��+� ��8<I7��-�&2�������Ü��� �R���q�a�u��L$�20���=ԴE���(=ИW���R��Vdtz`��uQ�z��2�{Z4�n���gr4�����@@W|`��������S�hㅛ�_1,�:��VT���G��h��kpzW=���2�����������ݦB3���i�4A���w� �1u�{D��*;�@ɹ��崚E�Z�8e��|��Q�Rɸ�	Fk0)B���]���v�)/]�>����O��g� ��q5->}hj
���R߭+�������{��ɮB��`���'ˉ���*���0�&�&&�X\���l�J�,7vķ�������.�)�� 4ރ��mJ�:v��� k	�ZX�Oֲ��6N���&�.����zu(�n��^��tU�@8�)��vyK/X&0@�<5���4+@a��^�+ԕ�J�?PV��u;*��Uq��:T�iؿ&����U�[{x�t}Y�}�1?u"Bp���B��������q�@��]���zu��
��z�������63#6f��^�lve����̚�:�����W}>��qM�
O˔�S[�[~���i���D`�T�����v�$�?�e9�_��c��9�����+���������v�y3ލ�[W���"�)�$���,\��A≝1���,��ٞ�(/Q^Br��̽UZ,�3�1�"��#��x��>@v� Kjq1<}�;YU�}�5pd$$W_�n�Q6<����ozs��g����)��H���bL��x?�����@��Dz/��Զf�lt������6�u�� ����M�T���m/���6����NY�GWX�f�>�9ϟ��p��DuA{`��%�yAC����SK�,���x��z�1�ã��]�S\��]�=
�T� �S �T���v�OYZ�)����G�����a0t�v(��lX`S����k8�hu�v�����.+�^@n�+3����0Sz��^���®��h=����5O��C�Ȩ�������4��Z�dt��˫�4�����u?w�H�Ai_��<+ ݰ��i�2N��b��0�f ���D����2o�㭌ZN�z�̙	vk�������?����=||Z�{�ܫ�3*� �{��׳�E���b�;�����P[���*n��;�|�ɲ�W]��qe@�]������5�El =M�}��2ZT]0��P��}�Z���i�&��|�ef�({~�$�9(:# 0�����V&B�t�@��)���B���v/��̕Xx�	Ɍ��K~�#�T��ßa��b����<6l��6a,:T�z5��u4�6˳�0̊�OH�Kl&$��O�2ѳ,�����ɻN�ʯ~�#`�Q	F����H��i�_ 8����*	x�p&@�e�u��؁}�߲uK��PԼR$~v\���ȺẠ7̉�Z��0���Qj�j���K!�� �f�G����Ƃ_�?,�>��k���:�մ�1�fٟݸ��t���IN���Bd�z#q7\qa����]�? J*[x&�bԄ*F�������f49�5P�H��m�me�aE��	��4�/��� ����A��ęD�qq��M���۶j��V}$� +r�U�0�&��������3m7�&�B^�<?���s�neyB�p��u������?A�,Y�43NE���ǡ�ga�m
�m|�^a]0�x��ni���>;Q�o��ލ�+Z�!?���3�f�rf�0w�~�<�1��eT��gSMsD��¨	�ڝ,�2M= f0d���-g���������M��p���"*嵷���f6���-���Nƨi
�c��=z�i�xkZQZh*$�7�р o3�`���h
�#N�q^��8<damߨ��[�0����^Z�6�
�6	V�y|h�-����Z�έ9�`�쯃�Cg*4�5/�NFU`Ԭ��Z��S�k�ж�V�GM:`qqv����d���E�(�y̐�>��V\�1~ì)cv�h{=�!��Tr,�$��O�}�V���v��
�.��~�?+]=���jJ
��+!u�z"	`n�D���n�9q>�)��Y�`
n#bрL����׼��;���²�'C����RH�)���I޴�^�j��O�����A����4P^Gf極���{a���@)!�Q,j�j�㱣4s�����6���#W d��T�_i�)PQ���>$8~����p,����`ig�5Ah��\���+�/��n+��1LC���W��~
\2Yo����)�LU������V�C7S��L>1���(�|��ȵ���P"����Ջ�n�ɢZ�)�����3~���V��Sb�@w`��c���%L%���jN��<�&[�L�`|���zQ����+[�P� �>��n o O���#�xѰذ`�h�˾���M�e�����D�}w��4M��BGŐ8���jB�Ψ|��3 �o!�'?1�1�G(f���S����{Y���ph��8=�Mh/�0
�B��0����� �6���I�6'���}�Ex���j�q�nC��(��ʀ>J:!�> �M5��P|N�j��}��x������q�~8���d�s�f��p:-����#$ɦBf ���p .��?��ٴ$��xXH�N\d*��4A1�8~������RU���Y#Vnb�?�n�����bUJ+�p��L3�C��~|D*�쬟4w,f~�
����Y+�f��r�����V����$+ǥś͸��_y+�@d���/~�瘟�v��<{`������o*F�`Zo`� �eD}w��c���l��Tx�[��&sC�P�qZ�
�ap�V���me��`1���D( )dV�<tC�,t��F��h`�O	,W?��d�.zb�dj�_nž� 3�j��� ~�f
4ce(�����mx7v�����A_L�~)&h��E�du;/�)P��9����O�%4q��}j��f<�,�?�F��	5l7`���f��9��0�}�dX�%�����kb� ��4��V(c:��)R���?�[~�Tl<Y��'V���g�.P�6N���o��$[���=b��u�i3�`4"D�n��#��� ��tF.�4r�/1Y�
+���
 �z��� �BV����%�%$h5"_�gYpP���T�    d0ԇ|���������V�Y4�n%3_?I,_|K�����4����P�|ڇ�F�3.�tb���p�Md�2w�*I#&S��N �A�d	I%�b��Ġ}��B��)P�a��R��1ާ�]��5��?�L���N�E�@�Mr-�xnw�B�XP�ٮ�0���9�w�Ƶ"���N37(����m��wB7S ���Y����^fcm�Ѐ�6��T�}��ZY���F�-0�ojȿ�dyI&c����<��"���a=����?g��2.[`yY�BYi�־~�dCh�jx��0Y��r�;EH7dt��QoF�ŵ�#4GYٜnȄ�2@�-�z�Pe�<�wv8BEv�mSM��香S��?�B���y8�Ef�";�"Ξ��,�Tm�'���Ì��l��V�+H"�+��8�;r�"�c+�h�4)�E�~�Q���6[#9�2�����.>��J�Uu��.���l�p���-0��Y�P��$���+��,H'i����a^��w2*x[�0f�D<�sa]ŪJ��h������>aU5��L�:�9�~�>�l՗E�ާ��4	4�(clޠ,�@��%L��nY�d+�p����kJnn���yM�e�Do���ܼ�L�L��a�$�$�ɺ��Q�l���L��L���n��ۋ� ��thƠ�9�?=��HFm����pA���Cڻ-��,���|��+)p�B.%�,�V[j�쾚%&a��rSO�sd�]���{��v̮�TU�c�m���D���L.a�y�-߄�qR���8��X��w6_�~�O��ku�;#=X��θ=^zL�n�oj�����|,���Nܴ?�>��$+���	��)O&+黧��w�^p���aB���͹����5�覢OT'�t+*Õ���C��wyzEe�+n�8o��I�A��T�j~��=�/L"6P��l��d�Wv L�5`�R[��gX�������S��������a���l�ѧ�<�v���f|t��6*���XD��1w2W�r��������Ɣ'��ʃ+�
�&�Q��$ky�&��(�U*i86�Xw�E�w�J�D��@���snA�\�ql����)����-
�Wa��k#'����t8o�
��1�9�*q�sx�Z�7��`���,����0�Ji����C����՟��6jw^bG��j�{����b���!i[�C0,l���A��.�������r���d��hkJp�>�.��W�R��ϔ��6��BI���m8ڦU�%���@щn��t����Q���ɣR��X�+�3rK����&��&�u���%��
��]�^�W�WK/k?uߓ�Ҁdp�d�a�U�.Al�㞁7Y�,p��a�+ie&�e`�o�������-�r$�:��X�U|��-}l����I���h<l���ڽ�5��p,ƊMUB6x��>S�""�.6��w���o�מ�x�����;6�t�&��Y��z�ݴ��[P�����Zoe@�	/�T�0B3�����͛�_	̈�}�Q�L^��Oy�%"���E�I�\�:���8���Ԟ����'J1�<:��趽P͠���<��Ӆ�o��S1*�{nm;�-R����Y�]�~u��-Œ���VX�{o�-����8��s*AxB ������B��AW���K�d9����זx��>j��~�m�5]W+]�Jڞ@��{��JXO��C�C/�ZH6�r�U1�R�-^hb�4;�Fz*��0./�F7.n���V�c�>��ƾ��b!���u4�4�)x��6����g�p�p���n�\�VG���>�Qzj��m	�b��5y$_�us�:Q#�3rf �ê��q��j���)���������sh�îǗfqw��_��wJ^��b(�����,�����9.`������v��S14	�(�����<�ޏ�V���bܟn_0��*h�}�����E���V��C3�f�y5u���N��/�y��ٽ:e�&H$��<����mۯ���&J�
J�� �ŧ���k���<�M[�.��v���>��D�.�ؠ0��qC��O�o҅�P�����\uW�P-�k=m�|��z����N����w��'�k�\;�a�|2�,0H�i:�(f�ȏnՄdXTvl���U�ߕ�Vz�̨K��_��W���a�`8d�_����y��C���ڄey%��t�ӑ��*��9�D�hkB�Y�C���'J� ��w�nt�]+lR~��q��*4��ҝ��$6Q��ڢԽjy�U�)>��*yB�S�p9�v��B�R^�BX���	>��{c��l�,P��k��s�A�ut�^�ς���C�H1��4
����m����=��\@Ǻ���J�����;�-PАT՘� 4<p��	_�3ޮB�+��i� �w��G@���y��t�JԐ�k�k��"�-N���`�Kj���FtF����ܞ���W-?M�tK���#Pe�|5�ʑk[f2^@5����6�G��F�}VJ�h��Q��v�әy�i ��6N�F�gJ�k�Q�+oK9���,�z��+�?���j���%�-X��Ycg�a��2@�|�sz��ð�E��vXގ�N;�
���9���Dݑ�d���MG1 ��������mb9\v���q(䫻W6au��w�n���d��t9����0U�)�i�[Wp��:3��̀ƾ��v	=��fSv4�w�lƇF�!�耬�?.��Q����s �A�G��W����;N��2X\����>UQh́�q#�O���^��:��/�O�_+��6a(�Dq��q5�������d�~gi��f(td�Cl�(��-�[tU��������m�ӈ�t�{
��0�?a�;�0=��..,G��������YP,{�h㘄rx Q��"#�j�AT��ޥt��m��fz��GJ8x
�7��٪Wd�J�jM��	�צ�a�6��ᣵ�p��j��i��t�BkEl�&O�y�v�a�*��|m��k}lnB�7j�U+�8*��xL@
�f��$6�p��y"��y�]hU]n+�8�xlap5m�R`�8�wl�:}��6A \O������G]�����E�w�pcg<k��z�:�z[9�Y�yi��K��Qw�&����u������ܹ��p�(��lig!��[��eE`��E`t?)+��0�4��˱���;Fw�$��8���]���D����2=��Z��&�3���>�C�t'hĬ�R��`Bl7D�>���6��\L�r��y���A�H�9��S���C8t ��GV��6[�cx[��_��q�J�,�Nv��cf�"�����r�%�:�J����С�uǢ?i@[4��Z G��� ֋�y�~I�����m�#ſ�t���>�=ň�20�uѯ���;�Z!�Q �-�&ttp�w�C�E�^[�+#T�(�COW��C�R <y��\M�ooyلG�q*�QzoX����<g}8_~�[�Ww���1K�on�q�w�]�Wl�?
V�Gw #�����%�k��ϰ�{V�øC�0 V�-�$э�HO3ĺ�S�ׄ G%�C��؄W7pԯ���R#�Dٹ���faT�XA��e��9��d���j(�
 �F�O�=�r|lt�/�:Cc���Xd��Jm���3�V�~%4�u���Oz�&6�P	ޅu�eƟpH8B9��<h��٪�k%]S�q��w��f �Ԩ�P%p��3z	a_ 6_�^�*A{x2���D%�WN�U�`ɡ	��ݒ���i�2�nY�z�c�S�l?�۶��-V�����5��e�J���%ѕ@=@(��s�������~p$�z�1�YU�U��su�=Qܰ�	��ڗ��&�w��."�b�v��ꪉ��;
��b�����q�U�; zf���^�jv�xTn,�t�,�z�[��p%�����!�F��ig=��'��n��3���|?(�b*�xx    ��kn�f����͵ׅ� <�4
ų"�r�mX���R^�U.��r)�}�6����茺���4��J�p`Q-$lA�Ͱn�+Jt ���	��>~3�X ��%*Aw���gA^hc��[ޏ�n0�Jp���E���1|_���nM�,Bv�U<�F��rhu�hU�;��RŲ�B����з���F�n�V���3]��P\������� bY���P�z���n�	��H��7C�����]Z	�j�[CE3ԗa|l:�N%@V�`�4�\^yhT�m�8O/��9za��X�iluItU2X�`\e8�CS�_�Pv�z�(�D#n���p�z��, *)�A�D�X1�S�sڽ��\%����%aZ	��|�d��?�`�[3Q��P��/
�%��M�� �J��p�9G���2��v�����:�e�;�5��=�ڠ�$��I{�J78|���GV%��Σ}%&+ax|�	�j֣�u�JtG��0�?����@�+t��Y6+c<�r_�S�8t�b6�n�/߆Q��S��T�Dm�NM�}`h�|EK�)�K� B�j	�3(!����VAT��pt����@��&6ʆue�Ds[vq��OX�؃8�J��`��U�`W�D!�֔��I��]��o�oղ���2���N�^Y$��9L��z.�w�?�}��N�<X7���WM�t*���F���³�x[	tz(H(ѥ���Zف�
����;(w[�XYeOTr,�&����Q�*Z%�X�4�*~�%Z�B�y�l*+�"
ʊ3�J<�z��p��J���l?���_����4&0:��Q�y���>��(?������|	}|�,��S���j���y��bq���v:0��?H��u��|ht�Uu2��H�aj��>-�+O�@g��sEcE!�3-���M��dN�@��dJ�D7�2�"�/(yl13�Zo��+� �5�@
��&��RI�Х ���(F#�դ<	����*�e�����ݮѽ/'�d4d��G����q�EFB��^���ۃ2�(������W�A��p'�Xt]`&��Dܒ'��쬩c���Ա�Vro'_ܵb���v��>�;�� 6W&��	)y�M�!��[N�(te�kx��z��eEM?�vg�Z/��׉�V�~�Ƅb��̑�~m��t��D5(�e»a;�0*A�������3�h+�)D<�]�K����c?X���p�2TN�l���A�`?�ߕ�g�d,|U�S��B�;�-�D@B��z�O��n���㛫D~xGo�NJm����?CO	��i�=!�a�\�1�6- Lݪ�*��$���>P��v�r�}8�X�ė�x��*(+qf�Rp�
�t�s�*�[A{��g�Cѡ��P���>�#9��޵mX���sp�����r�aB;�90��{QտWz5V�v��V��Ɣ�Y��v�NM�d��p���r��S�cX�����^�Z���q觥*��Z2�_ر����1�zN�P<B���A�N�a}��l�L̸`��nfq?��2:4P�`�W��Y�;�z@U�eV��u��(�wYpq�B��u^Z�nu�`����p���~��:�]�<�y2�g�[4ɔf���t|	�vw��ZI^��y���St��}ݨ��\&fZ0�+��;���(�TP��d%ע��Ν�;<�@rtZ=x�;�ؿ7Ϫ��	/��baxv�LA|���E�k�mE�uV����b�_��R;�I�c��bI@�"�j��*�Wy��#� U4��Ha�*Kv��a�b���^h��'S���F�}��E�].����*�<�%���nzuH䄔w]K�����9;��A	WA;�}�9/����K]!��Yj�����n�j�e���@k�R*�7A7���a�H��[K7���0�%E�	�b�\,ݵ���0A�A5���6ZEW�F�ś�PZ�Hu�'V�y��%�)"���-*4��8���qRv���`��C��ٛF�Ⱥ�s��&�:���E]&�J!���٩����L�N'��J9��7�Z�(����I�����dww�?��P:�/��]�ߕ":��4����e�	n��txh�m����e�<U��%�ñ���H�$��I�;q^���A�A�\t���z�>��mP��Jѐ�W��9!�邨�P��ww��V�3R�t�W�dfX�Y9��H��o�(���.����*[�N��uu�!x�V��uChN�(<�0X>GI�C8����V�>�k[#�U�¸�k`�>� ��I;u(���	b�眎��kLR^�(�����6�6n�6�A٩v�D[ &�y�H�آ=��:ῂiO< K�f��Tv	٠K�d��i�:�V'p�p�r�#��:a��V�5pi��{���F�K������4)�۾o�����؀�Jpt�6�Zn�5�s������w�1<*�2��^�b�í�y�R��
�mĬP|�Pdѩ?�tW��'3����v?��'�T��Y�-Fv�M	�v��-�;�-S��N���#C2�g�:�v';l��deY��}�V)�	5�	S�CP��.Q�.hW@�q�iv��q�8ga��_Ai��� N4�!�5ԋv�F�ud��F9�V�z-���7�#��R��S%�[L�Eʝ�$�C?��ԝ���� �g���V���ZG�2�\�Z	*��g�9��c��e�ثV>#��xv��䫰�T$�|�Y蜣�U�&؄�XS����2	�@P�X]�J��ot[�I���X�,-^5�W'ʧ��^o�5�PF�� FY�K�F�L�3D^�"̨���r+!����b�c�V�e�=K}��	N�����K��Yay��r@k�Jy�xQ��"t젓?���OeP� ���Z��v�b�F�y'B�R��y�A)<e����ge/%��l}�~�����?	K�:1������dv���^2�}�1?����JD
�޳w&*��m}�z:f����A5�i�[���K�F.,�@�5�}I9�۱i��ӹ2:Ah���+�Zˆ��+��]�30y;k�B�}X+O�Dh�ٕ��1z���"rӭ*8��f�S��,o�o�� !��{�n�ԯW�n��$zAo�'�����ߔG��5hka��.�[|5�e��@��Y�mVJ���VD5\v=!v>�����&�����Nt~k�:�,<VC��i�Z^��tE!�(�6�><*	+�	����۬���M{/��'d�N�*7�ぴ+~��NW9�	��5�{�7S�ە�W����qX�O�t8�����Ep[*Z̵#���R���+>�6�P��j?ٔ~Ș�l0;Ի�Ǘ�Qxn`��GK@(�]�:	��W�Ji��{k����Z�|lA��]�T���r!|�w3T�߄cs84���e�
�98[j(���à�i}.T~�~���V�Cz�k`��t�R~����_+�'>���x�zZ����U�T�O��p�Wl��k?�z���Fk>��	��{�_6�w:��=�<�"������F���� �Ѝ)�������Օz}5``� ƀ���)p.j
	j�?a�R@�b�v:�=&���ƼO\��5$��g�ܼ�%C������Q�ʡ�d�6ay?�m��@A���z
��=(��c��5C⭖�ڟ��(Cդ�	Ԙ��*fߟ��.���̘�Jj�=���q6O�y��Y��}Pʩ��#D�
;}ui��0�f�Z�9��v�O�KF`�����F7��K9pH��k�����A�i��\�c���A�Q���+T�}T����)tãn�4�E���w��օ�F~^��9[S�Da膵����a��FI�e1�jq��0<�b !��a�S�E�*C��횵2�0�',��c���P/~n{��T�� �P�;���8�*^@�Y:����U�S�8��Yo��	�9 �!��.|��\eh�  �r�����W�/�πU��    ;)Nw�ms)�V~��������3$L`�Ze_�':�� �¡�����N��9r8L6݇�A�煖*�Ŭz��v��:�&����sԵ!f�	����VJ����0Ȁ�\�5E�vʻ%��f)�q�͋A>(K�@=/����l	�7F��	����2�Ϋ�0v�Q�(�VT/�J�E�`��[}AH�h �p\�Ecs/�>�Ot��͉)�"s��ipT�AeM��	�Kn���lW�*�3h)H_B.~�@���=�c���8H���g�H�qy��M�"�u���N��'��@3�و�u�m� ��Z\�تx�V�è���	Ű>R�Ŝ_��{��@�+(�p�b�|q��~�L�N-���7����I�K�+�0�P ɦ��9hS�Jl(���ur���{q�~���@m���* )|=�Qy������zZ��7�v�~R:�y!�aci�����àDh�;1u�+N1�0��2N\Dj�s��RC��4�}�1XV�`��1���vy����:��yaZ���	�ce|%ht�}��q�Z���N�慅
�{�(�S�n ���/Y�r�r�����W@�e����^jg��"�y5�Ewm��{�	� �s�Y!8m�*�3\���k���A�Ugp�Op���E�8��8p�Ta��Ta��.�R���m�� �04���Zep!=RfG�<�5��Sl	Š�����D_���}���8Ky0��H��!����6��A������{�]Rv,�wė�%o]�����z�e������5(X<6�V���B��A7����r�l�f\^e^���Q�#���RğJ���ڼ0,�M@v~3�RzP�9��0�ż�|�Io��QPd@Imh���A�B�	�͈}�d{�n۱W"	BF��E�KLFm���?��;"E�e}��6�e��<ةe �L����-έe��.l�d2�S	���m��Q���p��Ӓ�g�;�Q��ڴ��_�luu�:�Pv�~�7���Ë�([Ӕ�Bh��t�_���r�ZZ�P�Z$���17��Z��Z}j�¡"4`�����Z]�������<�}Uyc��6���z�A$��>�݇Qu~ՙ��SG��k����^W߬s15ɖ )ß��U�
��ix��b����0��r��FUED}?,|K��N"��'絉s��I 1��Z�j}�,�Z׻�U�����M�^�u�tJ�ZX�З�E!��:�t�H-�Sf�A��sq�cX��Q)@Z'Z%�̡a��/��/î��jk!��A跈�TĔ��3uqRT��<DJ�G�vP�!u!$ �y�n(�e�,�Ǡ����]JP-�
��rx�L*N�NG9�%{�ܵ�:v��F�:0�[\�np�N�֫��W4�׿F]JR'h*}����F�yօ>q�7 I����.����Bl-�Q{��t�H�o)Wu��k�����Ez]��(����n�'��E-�4�RWBژ�m[8GW��a�8`�`��T�3�<��;<%YQK��	jN���N�._ȲJ���L,�P��ܚᤱ���]�1�{�*��4����w�Z���TI�~rt�\��I���aLޭ�i��4c�|�(���H�Oa�-`y�/�h.ꆨ�m`ȑ����5��^�c����r��n �CO��O�%�����8(���Q��Jh�u�п�]��Z5�����$P����V'�S-�<���V�3Y�t'��0��*"i|9aLd�TȬO�4
8���[�jqI��vҵ�j!�Q�g m���A7��񫵤6���8ġ5�Bׂ3�����r��km��3���	MG%����@�:eI�П}U_a��p�t�dHz?�ͣ�ɺN���97�+�*��sF�19�1��}7����J����Bї�����?6���TY�}Lbn�{mu��Z�j���ȷ���S�u��`������qX�J��=Q�ʊ�	Ao�b��4�&�tSuB8`a���V%�SK5�A��Qf�յY��R;{�Q��@<�X�.�Z�:q.�I2�f@��J>��'l��9K��Ou�U%��uVA�.G�
���J��e��\��7�k����Q@�7>�zc�����p9ج)%�uݤ:��h���,`�C{蔿U�Yy^�84Ze�U��nÿw稝�:D�phDj��Vf���h�"���� �3���q���cP^1BZc�4y����R������2r
����0�Ѧ�B���5��w�^�c��;��/��x��mValTl`-��*� /3��\�iFh�)��I�뗗L]X\0?�zЅX�T�0�Fd	q��U����IՀ�,\�}���qyֺA�:������Rl�v�n��p테<][��(�ll�4�N��Y'��@ۗ�]�_�����aiձѾi��R ���`r>�5p��J�����r���Ǡ���k��6��芞}{Ъ���$銎�����I��=�c�謘���aۦ?�&g��n�G�d�8����au�(�]0Y�-���{��,o�q��n��'�f�:�FI>i�� 72zH�+�3��kV�N�/T�'�<����U��F���F���J�>���U�+�0�4��_O�~ju�õ�5*7k�峎�g�_�;�Ĭ�D�*�N�{)�L�
9ϮL��bܢ��t�ܘV�nB���,��ʟ�Ϧ2&�������݊)��x�#K: .(T]A�Z��Ӣ�~�<$��ٖ�]^ta��eSS+�� ;��5�FS(�5�O��f��7t�I5yF����ꌧ�Jd�S����"KPFMG4�f�bm�����:)!Z�_��P�O��.�UqD�	�7�[��;3D�����&b�g~�ku�˰	x� @=�3�>�|qK_鿰���ӎr�Պ
��`���F9$VdB6Ã�v�z��M�a�m����$ ��( ��j�}R�@�n�[�����£�}�[6��_{W�
��K�{�[W�28�5e�����[S��([��(�8
����E�@�)&�q��E�A�P��
qa�x��0�����:�����1�:Yi ��^�/� dmɛ��	�U�?��F����l�����/a�۰��۠�^�ŀ�q���oLN��2(N�Љ�Ɉ�4���~R1�E��\01d�bo�o���^�h��2\}����A`M��à�	���,Ǆ�3� }A�4*��"f',�ax����W��nŴ���`���j�W�9hP�n!��<�<0c0?v�}{ԉ"YB3>�N���&l��^W�,�Rt�2����/o�����F>iYf�� 	�bΠl+2aw�a5ϫ�V}V���)��=���6��U��^�oF�
&`%�Jb���"N'e$s���#��7�*��G���t͉�7��^5�Td�ΰ �,��*��tߴ+��y���5����&0�yZ���[\M�UxRD�L@PѩJ#8���VG ��7�����9���:�+Z�甉7!�C��[d	��e]���!�	۶}V|��p�D)Z��ݰR�Ă�� �˾6%~��W.'�Vd��#�Iu�	\[��h�\�C���4Z�p&�U�ȴj����j�h�^���(7�07)�N<��Jz7���Lk
�0�0�|�Gᅽv��򖮪G�|�.�%)n��}�&���Ե��=�>?w��p~�%|��ԯT0�����0ˁ� ���ߴk�`r�Y�X8W|~����^ŨѺ���a��X�C3��jf�Urn�*m��0��~*τ*�֠��c��aK���Nؼ��ap�¨mb2�n���V��*�f��<����M~m��]������#f'�B.� ��i�v����A��	P#cM�|�=.':�o��~3�#F����696�I[���
�w��.W���~ߵ��ZZ�d����Ƹ�� p:��9(k(ݠ���JN���F"���8�����X��s�6]��4Ci��I�.Y=�N8CG��tw��PZ7u���H��QT��rv�5�~}���poK ����Z��GUd�j�9cA�o�ld�ҍR��6f_nH��    
�=���F�)�(��
�����i�/���.���R���Z��7�xX��*�%6.Ke�^����b�R���@e�C|w�q�/�_=L�n]/Ey��|fy���C9�ѵ�.����R]a��k�)Ĳt�����f�㟣�#�1��|�o�wp"4��Ĕ% ֎
��o�����r�N���� ��A�WdR�#����q��̛�j躶ו��qM�Y���)���{e�C��!Ϋb"�������';������9�WÎ��r�,�a�'3�a�})2�w�&�3�oc
�����͸�vET}��`�qz蔝��u�d1�iZO�ZO&m���U�l���S���.�Ds���sݚBj]��8����(EA��fz	߾�Q��jр�ϭ�7mY�Q�`4��馣�T�����<n�<VV3Yd	��(�H7D���IY�9��'j�i�U��g�0RE~�9Q�Y���tp0>��`_]m�v�a3�T��\��>`� c�/��8�fy��\�-<�Q{�t�P��fV8�ގ����C�QE�yB?,���1"��3t���B��1���l�76��"O�G�dг������7wR)�t�]0K��܄�A)�B�zq�<�`�u�&Մx���,rT1m}5�T�3ec��H+�� z�9v�v5��j�? �>� �fu)�X�!g�	t��'��v���r!Ɓ;1��!�r����+��B�t����mM+O�4��b_����q˰������S-2�� (������hŤw�g���5l&���T�lDd�zC�]�k���`��,:*�ѝ�]~�鍌�1t�W`i���t�!`� >~)����`w-�n�º<��qW\��)Ygu��-z"D_B��K]�)հ��>6J�(O���
Ws1�/�Cӎ�/Xю��<��\� P�����ԬZ:p��_.Ӷ��wՉY���p�~�N����s��cdЖ����aOkP
t���5*�L2=/�	y�� ]��%I%��'}7Lv�Е�����e�"+p �2ڣ�1���V�'J{h�qpx��[|T��P�nga��޴H^(Ǡe:U���R߭�蠆�(����;@���s��s���������ɯ+��T3�W�!����i��J窂�T
+K��`�A��H��<�Y5������L��a8��k�_(�PncQdɳ��'q<�G�)���S5�(���2�2���2�������{���!���e������V9�D��/i�/\��s��Ů<�# �pI��R�_�a�<è|Ɂ��:D��c`�Z|���~��v�0aq�	������c�'��`�l\NWt�?1l��΢�S�	��=NJV���t�����JX�.突�<~���(�D�8�@�Ӟ��"A��}�Q��t��q��(�Y3	vO�+z�A5]Z�	"aEQ[�H��@S�ά�Z��R�>���u�C�&���\z�g������k�Gʹ�}����v;u9��#}����f��ՠ���� �)� 5eYݤS��Ek�D���-0��4�F�	@p?E��F�%���9���5��OA9
J��Qq�eR��i����5K��
 ��sڣNc����+�����L��ֵ"޴�&��ش�AYlx��aV�&w�>�~�=���e��ٍ��v��X�8����e���U��D'�A?�K�xG�]XO�ɽ<1!K�<a�o��4�ʀE !�=��%�PN ���a5�����O�.m�j�)���V{˺�˫�Q(&/�i�*L�e���o�^�X��y�-�U��E����&Zt4��\|l�V�5��'��5dWΪ�{7m�ô�EDN�QQP\��ZW����	�UhKc�.:�.7�0�t{Xx�x�m/���|��Z�5���Hٜ�}���F7'�'&d0r��?of�'(q�k�s>L(�t9��pq��Et��|��]��F�s/�bO�Z�t�������Y'�C+����S���w=b��
7��~���.��,`Ͳ(�Z�\$o�#0�0e!!���-�Q��f
��p"H�T'��#����8��QG~��( !]@���-���B��g�7)��?��_�J�(�GQ�X��-�g�:
<'媥�f�9_�c��Z�U��G��u8�u.��h��\=�-n�f<��.��\� 9<�8��껦_5��ʥ�w͸E��۟��]6�9�<� ��0֌`��o��X�8q�pz�i��ixn��V$�>2�{�#��އ�!��F����X����姍���0ƚp�W�7Ch���E&�	��Լ���4���^��Ʊ?�cM���]�ay�*h���`=�*3[O+#m:Շ[�_���{���$�׭-Pb|C���؁��uL�	8:�`�U�s]@�GW�/27���A�F�hO@
'ǂ~.=���a�5���@�%�Έt�ݏ-�Lu�&RAM�q��zM���"1 ���{�"�z�������poǫ����H����ܰ��oo��?��jtF]��(Σ�T�2��ꦥ��SF�E~"���V���t��"�#��\��UC���{�On��%8������I��wq�eL�h���x�)�V�BWv��
�Tô�l��i�*s���jQ�� �6�t��_NO��N5�U��B���;ƨ-m�K�����k�JJ̐=A#�sw:u���Ǭ:�]m�8L����N�a�J)04]	��p����jQ����'�J��!����|;��E�"�PAt%v�nX�f䊄xXl���K���èsѠ����ö�@4��C���+
���t�\T�Z@p:蒜"q@��}�(~�m�R8E)�a��/�]�*���.}*�9�����՘[z����uSݞ�њ(�4��u�V�ٮ.�)�ߦ�>�O<N\��{����-
s�3(�̔W�W�9�[U���{q��<�����&�xO�b>���M{x�4]�G.�R)$��"0Z�s^/[��Q�h@6���?��6�ʎ{!�Zj��:��B㢫jK�U��S�Q�py��gc���5+�,5�˞5�߆�.pLTz/�#Ө	�>�ҁɁ*
��S3���{e�/���{��P���2�7��#ڇ s1�|w8_B%B���ԆrwXa��:��~�T�-E![�c�X����	�ࡕ��c�ۚ_�%�'�a��.ݬJ!�:%j�����i�ZwdZ��CG����ň.�S~*�{R	)s�i.ϭA+bzQ���������?5?è�J�dH�Z�@^(��޴�;���<�'$���U!�Br�Db�_�ܱ�T��N�y������]�k��S7��@�p�_V�ކ����-���g6�m��+O.|�%Y��Q�%y�Z7]TT��<0�^¡�|ĸ�B�QY�/�qV°+c��{�Hˏ��9',�Mq0��o¡�h+�B��a����#�n�����X���`b@��1�^�Q�>\$.�NG�Gk�E6��;N:��./�b��kY���ͦQ6�
���!U���،��������E�A �Z	
�o!u�<!�)�G]S�C1�M�+�F"A�|��f-��i����r��1��R7[`v�Z|���@�b�T�E���Vٔ*����� u��a��tR���B18�j��=�/�ݪ��fM�z��6��b���u1ի
'�y���)�����@'ȱ�c���f�O��:����f�,:�q��O�s�g��QQ����r��Rrqvnӆ�e��E�C�[!����4��#��	�?�]G��n�Ĕը�*
�Bw��������_t�y��;�_��aq��G��A���A��Ŵ�k�s
����l�#!:�~k�*6�
B�sH؊(!t;<�]��$%8���sDZ���6�ߦ�F٪�*!�Ყo)֟a�}�(I:+P�ŋ�<�1�:�����haA�y��AI�	)},b@�hq�3(󉄇��31�pP���c    ���/��B����Jm�����R
�HhHMO�����l���$@�!�<��)|��|ݵ��L`�fKJ�)Y���z�d�}�Q&��ev��gH��G��M��4*@���Ps����t�k����eT7�>�$h�X���M��9����xVtI�1<�J�e&��,؍`.E&�{�����p�Cr�o�|�K�[E��Tا�2���K��C�c���=�&8��}B���/�(RF�-K�����Fu��	)�a����,��ߎC��oa�-���A�˭\D������"N�����	z"0��p�`��QIʔ��0��dX���ۦo��z�8<4����~3��A��)]�T
�pS����C���t1{�����Y�����Ny]����H=ϵU�H�نn��Rh� ��հ���q�/o0����r���V�тc��˺�R8��\�,��v7��/���v6�'2��g��J�	$��g�I���̔ȶ��n)DDj5���d�9���me!�8KFu�ۍ�@K�H1�T�u���Ӡ��B��a� \��w�A��h���4�d��m�_]x� دgU<������^�sE��1�lp8�_�c�dkKɋ����wnЯ��I����82m_q+ɠ���_t�����(�Y�ZJ�J������) ���vp��-�� H�-G�e8eg/�{WH��<�|�E��n�
eBEJ6�����y��ưݴ�L�,O���J23���vE�}m����P\4�F�{G[W�$N�S=�3����Z�����t:
��F2�Y��B�K��j� R׍(���8(Q�w�na�>j!�2Q#�����/�4��۸�?tg���1�GT�׬�߅�}���*(���|�}"�"�
72K�)��OA�I'�����Pn�C�z�҅�Ly�sћ�,�����mP��Ks�c�A>߯XM��h�t	��Y����F�U
n�c���34�>���^��4r�7E:h#��ڮu;Y#5dwr��z5PF���ʄ�������(�l�K��˄(M��臲�n����2���C�+m�oè;b쉦�eE+��o����a*�z��.ֆǅj��xL[���~b�Q"����>�q�.<+q�
��\Oй���6uL�����3|p:rR&0��e���5�/͞��Tf��q�֔�hz;/�QW��N��-P�3ڳΰ���aбse"E����v�a��Aك)*�4IS�k���B�K�!�4z���6ھэ���	���%X�.<��k(��=�u�c���2��o��R�`ArS�1�N{���q3�A�8R&
����q�t�B)��Ѕjieؗ]�3���	���D����ro(t.seB?�x��71����Ƕ:��*�@�I;��w�R��61pnˣ�\���QVx��td1�_�
���Ԛ���?X�Y�/��&(���Ij�ؒ���:���*K��I�1��>.؟�n։/�w9c&��N�z��G���#��r5��>����U]ş~�?��Z���_Rв�O/��>ЖRX�$�֚6�Z&�C,w��z�*��	�?7� ô�ЪP�2pC�b&�#Z��ҟ(�W���7�zR����f�rfqn `�,<	�KQ_�#�a��#�Ћ��J���f��|b0�q�ղ�eb9������xh���u�i-"�,���<�"n'��i�+�pq�"�u�sh�5�/M�E�S*O��>д�};NOJ��2�t�q�M��MVީ��@	P���4c�nt6�e}BK�`jk�o� �w�����ۊ�3U+����٧�4(��ɴKQ�,Q����x)���*=����@�I�f�`˸z���Pmf��`���𨻺L&�):�-��Dn���L��5c����ܘ;��m�a
/M;�հ�4��,�$��"B�� 
�P�d�lT�]���M��`l7���d�S�kR�K�2(=:�p}�aK�`8UTLp����������f5����>�N������Fv�q8���|��SxT��&�����Q��q9t�2��Ek9?GC;�E5f�/�>�sԴ��ғe/�wS�����&�T�HX:ĥ�`k��	݌�I�F�Qt�T%~k;eBgrQӀvSœ���eq5��g�fv9L?&��: 5T�{ݻ|��a(���橡��@g�a0d��|;�i�O����)����q��P�\�@�N`��u��E���C�2(O5�t8��=Z�!�P�HG� .6E�UIy�з)��4�u�7�E���E�:�N#y��ܡwh�������I�^oґc4	��8�m���?�A�Q3	�(!]���E��NJ����m12K��?�f�V���$����`��*����,�a�B��ͱdncy�WF8��@~B	0��M���7�ɶ����`��M��T���.(�rg��.�6	�`�2z�,�~�����4�3���s�����S���߾�u�b�Q�
	�(�Kʸ.��P���1�� ��mEA���Y�\�M�9*�z�.�)NcX~
�A�����,K~ZK��+4�ԇ`�9,7x`�t�4cDV��pf��~��9�����#�O1�a���,�ۆ"0��MC��kSh˵��C3v�!����9MC1s�B��R_NۍRn�$f���,J����1FpS�����5��Ҝn v���l}C'L�O��MG��cÉNw)s���`�	�F-�j�y|���4@��c�|?��0prB]�M(��9�����`d#m\�9��5ܛ��tb:&���/(�RJ��i`H}�v�/��y����|5�D}��Kxٸ2� -���_4V���Ty���}���a��Ѣ6�,tn{P޲⯒�6	���B��a�g{hb����sJD#��ȜH���Do 2��[�mv���o�>X�p�8f
�Ĝ��@�A���=�*?��ؤ/?��rsX��L��7`����$�	���1���C��"=���z�2;26�����۰��'�*94�0�k]��/�(u��I�}��bf�U;6�WJ�`���ʪ.X�S\�1�7�.�*˩�ps=u&.��zR~[��R����UΎ�풳�1��ϋ��.,�b��)DD,��+����RL��r�a�o�8"�S���IF��l4x+��_mh�v�A+#i���"�ۿ�z�����+���e6�^w�;)
�1�{��0j�Za���,v���:�#��±�4�)6��돇�����'�Ie�3�_��2H�R�*+YM�_¡�1�Ō3�R��s���ըt�3��_RUADʠ���ŗ�E1���0���m��S���+�R�a��ּ��h�6;e��O��꼎J�Uf��P�0!ԁ�m=�j1qu��^�5�2��.����L�X <��R0Cd8�b�}��q��ۣ2T��f�&b��OM��g$�-E�_�ǭ��6���V<�3ݜ���nc�k�����.���E�HWY��s�1��@ff���0=�$LB<Ͱ<7�1:ƚ�Җ&�1��� B�L���6�oe��ʌ�4=��3F�,���]ize����F9�Uk�v�����I�^�]&Z�����mxht��MP�a�׼�p��Y?Uo�&���~�p��{�5n��z�3��/qT��Z�DVC���qG��b4sT0 4f����V~�6;�$��MPkԖ�o�Ѧ�*y�lzH�ys\���)� 90�� nFt6~ZO��&���@ 
��������a;��?+P��!(d�w��tK
��y�[�U�C�[�L%W�B�p���\QpR�Z�_Ӈ�vP��m~��*0f"�]p��mP�N��A�����a�|I�f�*zU����QW�����(�������;�1*�6����g�Go�R����t3��,^���η�I�����F0�h��ތ�&(���<����-�~݅�CxT�r�0n�]CN���ߵ?5M���xf�Ƽ��6��?��B0<̴M��u�zQW��R��'�W	���`��/�    7�]^���	[y��p���B�Lu�m��i@`8���R�D=���M���,�d�6�ih��-��OUno����	[�>�l��;T�u���l�8i
�2o]�*�RzJ����˼��Nw�'R}�G���fwZ[J[��<h��YK�vp������Ô��5�?7�l���	��f�o��v3(�!�pj�Tq�`�ǁr��
��mR4İŗ����Ȳ��(fU��Wuo:��+�	�0.���M�����Y�	�3�f�����W�֔��eN���ѝ*�`�r~El ܅�6�Uf�j��$Pl�{�()�z�5'�Q��6�t$��kh5���6�9��ma͊�ݧ�ʹR�8�/�t��Wߛ�r�J�F`����PuqlB4�l(�x_���gx	ۍ�:�h�b�!B�w��y>(�x�k���l�c+Uͭ�m��Գ橚��Ai�i��r�G�|#|
E0���
ʐ~"WI���[�[�\�����)�Q���	�X�����8�9<�{��6�P��}�:6�.z���|�,	Ӡ��p/*����F'/a�a��N��}�����M����Dh�`��A��3z��wO���p�)�����
~��z�k��J�����KP��5]X���(�A��"7�a�׫嫠 ��͠��]�.k���o:�'[�q/�� W�^�����������b����JW�/��K ���F��J��A�{��*�Ayl'J���2d/���=ń�Q�i��7p-`�g:s��n�=�D&� 4�k��9Jf 4���V l*���@Q�#zk���f��l5�:v��'���Cv'D�𑳥��Y����?����Wx��.���t߂۰��o��z�n���EITL #�!t����$6��竦:g��S��J�+�6��@9����{�4�|�����Z�˫����n]Y:�Sn��z:m����	�М�$�6�{
���Pv��!�Ȋ�W�ϟ�F�����|K�V�oS��W�@6 C�YcX���1tYVjk�n��h�#�ks<���9'Z����Wb-�4�A9l�@�a�^W�ވ��u���@J��dO�]��r�J`�^[N�A-�p�:]��
e��؆�vHN�w�8�����d��`�,�X�|�/Q�Vּj!��q�A?���ۭe��D�E�?+M���VA5ʹh�
�7��Fצ�K��c�rtZܴ��	� p��	D4�.���e��'z��a���#e%�'�o�d��y<C�^~R��Dh��2ϳ�"���]ؽ(�m-7Xy݂3>�\7}��lu3T67�Z��~��CW��Q�8���Q����+���1�i@R�l���Q��UB��	E��(��i�c8��Z���%abÏ (/�+]Y%fG��Q��؋Nɻ����)M=�a�m�]	?���e�1M��!�	�}�:+Am�8��:��Ɩn����g����?w��U��q���'-kS%��,��*��s36��[	���G�	�X�[M:��*!�F�\�=�6�}��RI����|7��r'�'�X�0<�w-m���+�W	�@ѣ@ť֫�U	�p���\��+;5�P�0y< J�nx���j�_)\�QtU	��.�{�g�7�N��P%�c޻.z}�uf7U":O�c��-^��«J G��T6|�j�i�M�]�r�XR�m�w�ص��O�8m�>g��=�S.ӆä����!W��.�e74�oCP�A+	r�vy��_<Q���8辮rTe�V�����4nwv���P%����H�YĹFڴ�׭2�v*󐭁���k�^�goÞ��
��
	#қ+�x�bƷ͸�Z�IS�y�`D�b<�?l�a��QJ=ߺ�������R����;�,���P���^t]�J`Y4`1?
�h��]��6N��h>�([���q��\yN��9���,��8�}���k:�T	e�0�Q����+��jV� ��G]{�*E�1�Pc�0����a׬�7�0[�aw�q��Q�b�o].!�9*:$\��2[�1�kt���e�k��*2�ÿ���>���- �ïLY�����hIϣ+���IgY1*�|��<��q�"�m���W��`����tm�*�HҡoQ�� I�٪�,�U	�@�sJ��w����.u���Z1�_X�śa<����7#�i�����AP�CO�x�]�Q�\Xh	���F% [,n�AI�V	�(�Tq����t%�*1"լ��(�x�����{x�VE-�[�.�(^h��*8[�n+.G{�b����SY��a�Ʃ���M�/J)�J�%�)@D�Պ%@;
�T�Z%�ث��	�at _�/mCݺ��_Gye|	�@��iz�W��b6��س!��2O��s���`/s	������C���fps�A����!�]@��e����)!�A�F��u��(���J�W���H$D4��
 _t_S?r��k�T�u]mڠ�i�D} ���
pU��j��ӯ:��NZ�A�]���S"�*Z$��Vއǎ����ɉ��[�/�?L�N����Ϲ������~���ٴ�H3�0 ��Rg1��~�m��2鞄�l=SBe��w�y���S���@QAg��|���b���T�1��YM;�l%T8*΃�U�*Rت�が 3q�����r��2�q�v1%��й���e�k
YF�o��9��"BR)�Q9Y�`��6����f܄ݓ�"�^->��[E�h�,�ݶ^%�Ôq�=�7����`>q����=h!޷�v?(ǎ��|Ԩ�B��-���	
��bZ>K|��{�Ve'���a��=d�BߪˬB��v\⸄D+� K��$���mf[�{��q��	�P��&��Pֹ:��*!��\�)��a�| ��G�s���ǰ���U	�(0�D�@��`o]��*�G�nB;j�)�Hc|
�A�W�����,���ݤk�%���q2.`�|	�eӝ]�Qo'�à�u*��A�U�fr�s�&�C�oQ�=|�'��IUKP�	\a����aݺ�dO[���bx�s���ט�[���r�h�9�_^��)W�s��>�.bͳ�C6���㢧���o�~����=u��K�F.)��n��������~{և��ݤ�p��=Ѕ����+�Ju�����R���oB�p���K����wI�8�=�C{�%�.qP)�ѻ��m�S7\�t�x'h��ˬ�;���զه�&l��7s���X!�:p���T�D|xC��9��e��|OG;�����c����nYalD�9�t�@�*�;]���|�s���_m��F����QD� �u��Vx:�x1H�&ϛf׷U����"Ύcu�=(�.b�:�q�F�.�q��8v�b�e*X0����='�
 �M��ێ���w�E%��b9�hP�m�y/"Yo���A���f���F��Ҧ�@&� ���i8*�|�8�>8r�s&�T�i��j�.Up�M��+]��&]�Fһ�y��%Ь
��]ش?uyN�u���.: /(�'�S+����<��)�}�<r��Zp~4l�i���"�_\�����3(%�4�1<(ޮNE��`$ 2��,�;��t��t�2gs�M�?�Q����s`�l �w}���a���_�߄t�Q���-C��J�q;�t��f�b94�"���!�m�~{��a;5��aPV�� =*���bG�5�<*�L�@<����D\r������%��O�V�=�n�pY�����a�J��wA�t\�h-
��J���Dw�*�;x@�&l����]�;�����EE�0����cxn{]��	ă"��d9������,��L�(�Z)7fq��"��Ҷ�N���)�D��Rq�X�]�־h']b= \�g@t�~j:H�����N�X1G�~:�MˢZ?t���(��%�E��񄟺����Ea�*����q{8>o��j�=@�7������/���p	��+�'
]oWG�~0N���4�5kWo&墢�xn��bJ"�a    ������	�Ȫ\��}h��ȗV,�4�HcW��2���׻�8+d�!ΉJ����s��f��}����Ĭ��O��h���h����K�FO) �<"Z��H7����y���������U;a�B��Yr�;_��9�Q��� dX�(�S���p�0�2���Z[[��O1�9jPhH�+��/4�!����g�K�2vD9<v�N��b��V�i3nO�1y3���]�>f��8^�K���rP�>��/�ȗ�,���K�T�vҊj/�9��ѫa�J����@�d6���G��J�k�Q���R�Z�bD,�s:_WIb���"�����*��D�����C�Y�����DWW�K��kyh̡h��bm�( �,�ɳ'$�e��w:w'8��w�̓��vb�E��s��eu, ޝ\]�К��`���,�>Г� �*�(�Q��R�ΰ5�4�_��0*o�D���Rp�TFn�W����u�.�N���?��W�v�J$ԹU���)�cL�^\��=����"'EL+$��SJ�t+&���!|�)!��?�(Q2�1�p�^욱}�L�I��v�tj����P���r��⸽Q�NE>ذ
�RD�]sh(�_�d"@j�����()n�%�8�2��6�.4���?���)��pO��tGl�?���,4�Ӹi��Ӌr��yQ���L�j�0��,oRI�)��`���WӋ��/�X�(q��=Q�Ή�0�`���O�V�?>b��\�)w���Ww���<q6������4�C\�@HV���%���aҖnBGa�&;0�-�do¾}Э-(+�����`���F���<�O_�,��W��^�0��x�~{�t#>�,�\��m���L'hO���gq?�A�n��b{�}�\��Eh_�ax�������������3����z�h5I� @!����R��c��w��%����Sn^���";��%C0��Y7���O��*��8�_!�k��S
{�t��밟t>�^��yU�-���N�(�{��B�J`��|��&��= ��h^C���s��۶J�d��(TY��(&E�����mR+[����QV6�y���n��!�p�'
)BA�)�	� |:�c�>n�Z�tt)@���L���n]��UV�/��n��;�W�`�ї�T%(�����0�D� BhY_��qX�b���ݺ^�}P��#	tܾE�I��{A��V�f.$\�a?<�cA_@>������A7��b1��d?ם��	� 
��7w�@��Z'c�	�E!7���,	�R|�@(S�^�����߷a�<ĄWK�Qbr�9�����uG��@2��5�` �`aEw�~���	����-^}���;
a���f�'Js���6t��ZJ��,�ӛ�j�vq�[8���<�EQR��*K'�a"��+��R�t�p�{�g:aj_�'�C���!a?[)5'})e�(���O_�U���ձ^�z��&8k����f��?4:n�'� z1fLi��+�\�7��=�~
�<�¥j��[ݖԒ[��ߎ�K$��H4Ht[z��+��JN�'���e4���˗k��z�t�q	�p�Y)ڡ�������QA|���s�EدTRBN�xd�0�0��1�a�E�hq6��{�����j����|	��Dz��PCA���N��%��F�A��(eF�4m�����R�y��;8�a_�Q�|3�k;8��A{�����O�F)_�
#Bʣ��}��v�6�+Zah��,Q�E19�(�z�����#N���>a�1(ʙ��F�����ΜQ����1�5��s����J����w�W�i՚��p0{4El��־蕷��pɎ͖־��^T �.?�G71=����p�U��֓�n��fh�[+1ped%�ދ��^���tx�CR�	m�az>oTs�.!t1X\�h	 ���$�+Ozb5��8����~�k����j��;�Z�E�#Q�c�+�,ww�=��n�m���HB<
1���b �q��K�4t��t�u0XJ�ӳ.M����s��0�u'-]*(��IX��;®�\���)�q�6K=A���QY�x�x�p��a�.^N�Ǚ=���%�o�.�n'$�{M8�����A7H��O�c�=6���jǄu�q�ݭ��7�a��u�&��>��h�RBr��m�����scɇ���]8t���pa�L�]��]�,a�B� ����ts���ZJ�,BC�+ZQG�8r�J�{���~rM��V:d�	-�����W�*XP}���:''�������f3���:miVpz�J���~HJ^��ӿ�ۯ�� ��]R�֗��B����M1JE�@2���*;a	����_F�+����cq��,��<*u��,\8����e#l�����rZ��k��s��n��������`@�Эz�o���>s¥cM�ѹ�7_��v\LE��Dr�>�*)��\(�� 8P��J�T&z>�7�`�s���!��ji.��q�ѯ�A�S�,pѲ:�OC�]W����3���J\tC*.��r��
�ѝv"�	~���%7����ka���p^�2�6,�Bg��j����\����#�lU���֔�
�{�ǆ�D-}tW���_�T8/��)T�r���L����AY�2�[�)^���~80���}�nt�>!���*��ޚ�m�*�ν��C;�؛ۀK�Ƭ����*����}7}��z�md.�tf3�F*��CY�����)u�;�ZDv5�^�u� 72T�=��q����	ـ\7�$�nZ{�ëO�E+1��Ū���ր�4�������i�
X}"6 :��*�~)�R����bZ.�s�~�0���U�>��2��t����&ũ�}���3/T�O�T��ׂ	��~��[��}�˜�q<�8������a�\C�Z,*�C6�Qy>	����YX����^�)�\X����T1�����F���� �MjFZ'� X(�&�P�p��(���#�����ӏ�T'B���7���Ϸ�+����@�'H�Yԛ�S������D�.z����5Gz�W
�z!�@0'�j)���~�7]F��B~b�3s��"�u�NY��I9#�]\��o�FU����(�<���a��Y׀�����L^QEp�-�����(�.��*�/��vOQ�J�,�Dk ;���8J�߽.z�	ը��~���1�3��V �hDo	��r �K�.9��e(� ���>�ͷ]?�Ah�#T��~n�ߕ���-(
�5�)F�(�ԝ.�(�{�������4�V�"�ʣg[�O>��A�2��a��+��1����Q,z����ó�#d��(SNyqa���~���{=��:�P_� 1v8�J�^��Q�Q��ڞ�rkWa�/G���p�ѓ�˄��]�T��Ȩs�Nq���9lt}R/P��Hl�8�x�tq�u
�>!�`XS��.|YЖ��8�,��-47�H����˦�ae��'���q��[z�����^�od(fD5��_��r�Ko��@����������/� e=+�߀�.J�W�9�$�|"2���MƓt7�f�v�_+g�2};����*k?��ݗ[��A`V��.�l��Èaݪ��g,ʽ�����f�.���L���F��
�֢g/ HC���4T�uKH��8F���a����	��~��|�";z(�.�J�;e�'J���ArB�x��|�^��N_�*"���B���J$ͰZ�2���0�:�`X�ڵ��t3U�򤰏�c����0]��'V�?+��yZ3t�NgF������+����zD[Y�Q����I���h�7f"4�N��b�>�p�Ҟ��8��7|EtJ��'@Pջ�-�7w�!�z�^�� ��\|/���S���j�&58_¡_(}�|�3&&�C������g��Q�qVӳB3"ǦB��>ӻЍ��,��e��iM}-0�:F$    t����b���f��z��|Y�`�h�P�)�xt������h�1��H_�u�^������:$> �*+��T�I�A�O0��0"B��3��}�T
)Y��,�_�]��,���(Q�KwE��̯-�@ʝ"f��Q��N� $ޔ��	=7:�0�qƲ�%T�î��X�s�.J
�E����}k�%1'���7:�${r�QGzgOvEE�Y`�����Y�-,�J��3��f��:v����B��m������e��/{�$ߔ�6�Ӓa����;@4���Y3���FG){i�RQ�ͻր��]�]wV$��%Ƞ������~�t��>�=��c��������2L��M��lQFkK_M>�a�(�D�����Bx)�A+�)t/J��{q�U3��5Ρ���E4}ԩVx/��v��$���ӽ���	��6 +LX�J3sXp��}B?�P���.���y�l?��p���|m6��}�~�/����^ �t�[���PՆ�N�.��mi哧�V�ȇ��w�[{P���T�Lgq�VW����o�p��*(f�Q�Қ�r�+�]χ�J��<�,!r�/�V��V�:iM1�\���+e��?4'���a>扪������%�z5��^�V�O���9���K��N?*AZY*l��%m�T��6Kȇa9:��A)�|�K��rh�4�͊�O�M8��l&D:�c�>2C�i4�6K��,��#M��ۦ�����MA�뱙���j^�f���`T�����~�U8����;pe�[�q��OѢ�B�ᬌ���`�S1?C��#��1���ϧO��+M���g����zĪ">-(�c���v���t�vvf�Y���cb��i�
�8(?&	x���G�M&�o���Q��t���v�\4C��O˧�UG�x�\�ͺ�>�0e��G��� u ��]�o@K��"�S������YG�ъ'�o�hxC"���@��*�V�	��Ӎ�� ��w��&���׌m' ��F/�b5�R�	3��Rb�U�*��-���������PQ��+DC��m�{��`�B�e6��ڨꊖ~�ɷI�SČ���Xb���-
<]�c������.��|hw�R���;��*�s�� �a��&�i]��Xk���_7��¢դ�f� 5f�F0� ��1��@͞��K�aN����*ס��y� 5A��>ڇ�}T\>�*]�J:�1�T�6F?�n�������s�V5E�o�� ��U8�ꏴ��m�>[�;��Ϧk�ͪ��+	A��-:p�CYr�y��L�"3K�JTF������a-����_@�ư&|
s���İ[��ƍ2b�P��ll@[�н��7z*���2�]7��N������rt�s��u�z"EΠ�U��:*�*9Z4U=�qA���+���IO�D��b<�I)@	m0\=*���Qr�0q�z�c3���������Q����7�N-*�C?}�ͥ�Ѳ��y�r�t^ݵ�Q�=$\$G)����!l{�F�iӪ'��+%F����)��-Z����
f�hp-嗛��Xʜ"��[�x�O�;\�]98�t�:qt�q[��=�$��F��bkY�%�Uh]��׍�pU�$΢���p�r�m���R�u��	�a��b<4��]ZRpX3(1�����{ۨ*hŔ���g��r�
U����UA�sPa�������[� f�|�qT�*u�`�R�"R�>��19�ba3��@b	�a��j�Q�$��h9�,L~��/�p3�U"aC�Jy%�D�p��������ԇ��_&*Jg���Wэ���!����6�0�����?L�R�g�:�|R+WD��{��K�BhMтv1D#�b6U��M��(�Џ��Xm�e��c�֩�u��/mHʞa�����%J�#Z��AQ���a�)���VYÐ"��#���`�*�����h��h�@0Re=�?(zQ���̝VH��m��z�`c�o�Ys"?(ޚyXp���~r�w�t�)6sk��\K��u2	6�,~m�c![�O�m�^6���֕Սw0��χ�q��Q~ZV�V��e�������|��������m�1v� ��r8�Nm3��:�r��Z�k�X�=��9��k)Z�5	Z7ŋpC�"��������EIڟ��9�6�)�'�p�u�!��B��q���t�o�����pԺ�=�[���%|�T,�tD��e���v�N�۽
v�E��Xe6�Ǎ��N��Mq�pk�a3�Ör]U:�3� ^��a�.*F:�� +����%e�9����I�[�I���v�,{%ȣ�8�ݱ��f�'�&���Y��I��xv�+z�5��t�-�#��[���N�:M&6*�Q1�'Зh�~Н�&�g��������N˦�����y��b&A�LK���x�ԁ.FP6�M(>�3�U~��ڣ� ��r� �.W�FW�2�@��X�9*����US���	�IΙh���U��5FD���F;D�m��Z}�}��������᱙�(V����'�9��;K��J	�}T�s��1D�f!�~h��I��YEw ���Z*�6�S�T���@��dJ��E�\�kԳ�E�&G��Pb�I��`B��~~������uq;E�����n�7�wl����c�Kw�
��1	xE@���G��{<���v�����( ��O?��IUZ�H�w')�ܓ˷f�)��gM"@����l`�\���|#t��$%�GJ����s��.����q�w���|EOʞ�������Lϟ���l"@�S����E���Z��*{=ZU�����3�"�Ӹ���/:_!$A�cA��䉶�bմ�<�$��6�ӹ�p���X1��S�]r�@7G�Y������<ǂ/��
}�7��7.Va1P�k}{2�R�h��9�Ъ�*iɟ[�?B���;�[��[ʻ� �
85*�A 	od��Y���"�5�7���2Bߣ���;{�zh1���Ŝ<�:�Q��>���.�e��$v}`�Y�4��֛F�D�Do@f֢����
��ˡ����0��)���&h��Wkew�$zӫ%�6�ݙ�bEy��X�y�Xg���qXi�A�)k�[
<�*���~��)��B�T���Z�p���n�yǽ��k�K��<Z�X���2_�+�2懯.��Y�2h�P�p������;�V[�K|���b����ih�͔��C;4��%����p3χOɎ�]��9��9�"�<%�0G�����}瀬o� ���������@�<�p�b�����¡��e��OV�t?#	�J^�H��|fm�F��u·����À�<����e�ըyT�{��az���+�	xd?]8�@���C_�Sűz����-E����Ƌ˖G<�K��G�2	� D�<�+�s��#�q���Ǳ���Z�i� <`J$�U5����͠;~+9>�Y$�:�G]s�$���ބ���~��2{�> W��z�w��t���t���@��.y��@��iՏ��-��a�|�Z�5vхt�,�ۮ�_Չ�D^�~(2��i����'�(aˋ
)�?����Z�>A+���:����ml-p��ύNN�V?��(��5�P��_�u��~�р�]���p��^5�f�I��\�t��l�h7a��o��ʷ�=�~��r���*+�G�|I���t�I}Em���<E��:sZRD�pס���t5��J���8����\�lw�AY,N��o���)��MWK�#�	t\r���_���QRƝЋ|�Y���0��#L\0���m�ޞ%ۍ2�Go�:��q�^��z�=�s�0���׬�r�e	�ge��ѫ�n�az�>(��9Ӷnr�}�Y�X#�=��sn|����J��8'\ڷ�����H�ϋ�}J��
~���D�	{HO)�n��@z�[��6�DBXj+��%W�E��@�è;b�_b�y.��^��Rx,1Ї�#f�>ӆm��Uw%x9֙C�
�RY!� �  �k}�w�F�&��t/���ֹ�:�ںH,5�(�����[��QW��'Ac�t�?R�F`��2�Dur�bpzzӼj�/�2��儂1@����>��3�JPU(/@��b�������'��#���b��~�#Oo�`T��@?����Q{z�7�j�M�䙘m����ゲ�Z7��'���a�(�>�¶m�S�y&9a)Q�16�j���&�$|�'�ba����E��e��m J��;y�[UNeV��93�Ns�.
O?���������9�����~;ݹ���;�����^�Yndu�§�Gk�:����w.�?ࡘs#�����_ ҹ�d�r�+�,�g!�ܨ��l.(g(F��/ua&��Z�,�F�A2���*6�)(=�Ҝ2��R�<��<3��-(�iI'�Ândܸ۝R�MQ"P�����*��ᰚ�*�fZً}`�Tp�aۻ�Y����`?�O<�>�,�}?�R����U��r�� �U��6�sy<�<K�G~Z��훋�;�pZ��ƿ�z��#� �[��O�;��'�QV��1��n���Fy�? yH�����~X���O� obP��_a��W�r�&
�8���j��v�֮�.0�R3\�u;.?qy�`�_"�͡��u�0z���묰��P�����?�a��}Z��o�}PF*'w;�?�"�(��I9H���0Q ~V@�J�h�P�׍�	)X^.\G\��-�X�?yD��m^z]�(���7�+b����csx�C �E+,^jVl�A ���U� � ^�Q����A�6 �!��'�ip�ݎo+�B.�:N���&�M,ƭ2�L ��q��ֱ�#�y�?�8Y\T��'�M�(A~`b���c����cw��lb?'_��5��_)4��p���p�@/?�����{�S��Ȫ胊���V�;�+H�G�o���_�Ë�+�K��f�C�tGa�se8[f�C�뵎w��v�����E���!��A�`z=�Vy�K�^��i��^���L��n��J�S���5)�hGYm�3ԊN��0=r�C�t}����.usk�H����³N���Bу�/JT�Y_5�r��N�#��Jz3p�0�)t/c��k������x�n��p�~��ʽ,�=�c�8J���yP���]�� {r�Z�<Cu?\%UO�Ր��4(��h�\<�����
�ӷXr��HT�
�:{2ݫ���?(l�Ge�"1 Ȭ7q��;LՅ�N�0���i�$���u���m
~Ԕ���	s�Q�94ju�
(�^T���
�AaO�A�����PZt�{��/�p�V�֓��B�EC��|ڽn� ��	 ����0}Rj=����G �8"F�\�֑����J�X�U踴���:�駭Ra1���O��Gi���sH�G��0 3l���
�	ш^7;��y{��Y+�>,�H�Eˢ�`Q8�u�u�P��#1�+�0h}*�
Ł�,�mÙ�mOa��g:�9 �a#M!��o+��'��m��Y~	J��<����E	�Z_��u�K8����::����S �l�Q���b������%u��pt��N�t�Ǒx�aP^N^b����W��Bփ>.�t|����/���E���F��}l�e̕
�`�6O�2��;`�H�Rf�2��v�M�G��;e�v�M��������zr�t���-)�a��n]�[����+���vr����8?�ǰQ2cyB:*
��vCt+��oa�\7�'����OQ��S@H���m���3�L�?U->�w1���h��\.X�����dcM��ϏcP�P��?<���a��e;t?��,EFG	hb�By1�n=:L�f'Bl�M��3�����!��D���$K/�qCQ�B�ϒ�?��p�����;�nzZ���P}Y6�N�2��ʟ)~��|O| ���P��;�ʕO)}khI��K��sط��#e.���
��/$����7ݛ���z���9�>�iO)�VJw�8�@J�!���4�F�<�zPׇ� ����k^�n,�&p��&���B4�|��pu�J{*�����}E��V٭�F؋��
[�����v����d�wK��L��ߦ���.�	����ߧ}�t��M��FlT�々��)�	��>�8
���n�	ހ�3�v܄�E���l�U�d���%���ӧ�s��ºř�G�"[+�@���ͧ��g����-���      ,      x������ � �         N   x��K@0�񽋑���ҢI�5�D��39%�Jd�[Ĳ���`�`�"�;,b{�5?�MJ�W��pj�:$_I�      "   2   x�3������K�21R��9K��Rs�L8���S�L9s�ӹb���� 2*v      $   #   x�3�4�4�2�4�4�2��\&�Ɯ�\1z\\\ 4�z         7   x�3�L�LtH�M���K����Lt́H��������\�����Ҍ+F��� <f          8   x�32�4�4661�,.�S��OI�4�22
�X�s:���&�+8g�T%b���� 4j         p   x�e�1
�0E��e�C�K4N�2MP$A4�)dV?S(�mns�!my�9�p)~�2h���%8q�Ͷ'*&�9���eQ���X�ǜ�c�t������{1�1���b��      &      x������ � �     