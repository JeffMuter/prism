PGDMP  7                    |           postgres    16.3    16.3 Q               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    5    postgres    DATABASE     �   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false                       0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4886                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false                       0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    25171    events    TABLE       CREATE TABLE public.events (
    id integer NOT NULL,
    event_name character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    eventtime timestamp without time zone NOT NULL,
    description text NOT NULL
);
    DROP TABLE public.events;
       public         heap    postgres    false            �            1259    25170    events_id_seq    SEQUENCE     �   CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.events_id_seq;
       public          postgres    false    227                       0    0    events_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;
          public          postgres    false    226            �            1259    25144 	   locations    TABLE       CREATE TABLE public.locations (
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
       public          postgres    false    223                       0    0    locations_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
          public          postgres    false    222            �            1259    25219    node_resources    TABLE     �   CREATE TABLE public.node_resources (
    id integer NOT NULL,
    locations_id integer NOT NULL,
    resource_id integer NOT NULL
);
 "   DROP TABLE public.node_resources;
       public         heap    postgres    false            �            1259    25218    node_resources_id_seq    SEQUENCE     �   CREATE SEQUENCE public.node_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.node_resources_id_seq;
       public          postgres    false    233                       0    0    node_resources_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.node_resources_id_seq OWNED BY public.node_resources.id;
          public          postgres    false    232            �            1259    25122 	   resources    TABLE     [   CREATE TABLE public.resources (
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
       public          postgres    false    219                       0    0    resources_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;
          public          postgres    false    218            �            1259    25154    user_locations    TABLE     �   CREATE TABLE public.user_locations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    location_id integer NOT NULL,
    named character varying(100),
    worker_count integer DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.user_locations;
       public         heap    postgres    false            �            1259    25153    user_locations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.user_locations_id_seq;
       public          postgres    false    225                       0    0    user_locations_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_locations_id_seq OWNED BY public.user_locations.id;
          public          postgres    false    224            �            1259    25112    users    TABLE       CREATE TABLE public.users (
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
       public          postgres    false    217                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    216            �            1259    25197    worker_activities    TABLE       CREATE TABLE public.worker_activities (
    id integer NOT NULL,
    worker_id integer NOT NULL,
    start_location_id integer NOT NULL,
    end_location_id integer NOT NULL,
    type character varying(50) NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    start_latitude double precision NOT NULL,
    start_longitude double precision NOT NULL,
    destination_latitude double precision NOT NULL,
    destination_longitude double precision NOT NULL
);
 %   DROP TABLE public.worker_activities;
       public         heap    postgres    false            �            1259    25196    worker_activities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.worker_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.worker_activities_id_seq;
       public          postgres    false    231                       0    0    worker_activities_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.worker_activities_id_seq OWNED BY public.worker_activities.id;
          public          postgres    false    230            �            1259    25180    worker_events    TABLE     ~   CREATE TABLE public.worker_events (
    id integer NOT NULL,
    worker_id integer NOT NULL,
    event_id integer NOT NULL
);
 !   DROP TABLE public.worker_events;
       public         heap    postgres    false            �            1259    25179    worker_events_id_seq    SEQUENCE     �   CREATE SEQUENCE public.worker_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.worker_events_id_seq;
       public          postgres    false    229                        0    0    worker_events_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.worker_events_id_seq OWNED BY public.worker_events.id;
          public          postgres    false    228            �            1259    25129    workers    TABLE     �  CREATE TABLE public.workers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    religion character varying(50),
    age integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    work_status boolean DEFAULT false,
    injured boolean DEFAULT false,
    strength integer NOT NULL,
    intelligence integer NOT NULL,
    faith integer NOT NULL
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
       public          postgres    false    221            !           0    0    workers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.workers_id_seq OWNED BY public.workers.id;
          public          postgres    false    220            N           2604    25174 	   events id    DEFAULT     f   ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);
 8   ALTER TABLE public.events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            J           2604    25147    locations id    DEFAULT     l   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            Q           2604    25222    node_resources id    DEFAULT     v   ALTER TABLE ONLY public.node_resources ALTER COLUMN id SET DEFAULT nextval('public.node_resources_id_seq'::regclass);
 @   ALTER TABLE public.node_resources ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            E           2604    25125    resources id    DEFAULT     l   ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);
 ;   ALTER TABLE public.resources ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            L           2604    25157    user_locations id    DEFAULT     v   ALTER TABLE ONLY public.user_locations ALTER COLUMN id SET DEFAULT nextval('public.user_locations_id_seq'::regclass);
 @   ALTER TABLE public.user_locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            C           2604    25115    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            P           2604    25200    worker_activities id    DEFAULT     |   ALTER TABLE ONLY public.worker_activities ALTER COLUMN id SET DEFAULT nextval('public.worker_activities_id_seq'::regclass);
 C   ALTER TABLE public.worker_activities ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            O           2604    25183    worker_events id    DEFAULT     t   ALTER TABLE ONLY public.worker_events ALTER COLUMN id SET DEFAULT nextval('public.worker_events_id_seq'::regclass);
 ?   ALTER TABLE public.worker_events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    229    229            F           2604    25132 
   workers id    DEFAULT     h   ALTER TABLE ONLY public.workers ALTER COLUMN id SET DEFAULT nextval('public.workers_id_seq'::regclass);
 9   ALTER TABLE public.workers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            
          0    25171    events 
   TABLE DATA           ]   COPY public.events (id, event_name, latitude, longitude, eventtime, description) FROM stdin;
    public          postgres    false    227   a                 0    25144 	   locations 
   TABLE DATA           w   COPY public.locations (id, default_accessible, location_type, longitude, latitude, name, description, art) FROM stdin;
    public          postgres    false    223   )a                 0    25219    node_resources 
   TABLE DATA           G   COPY public.node_resources (id, locations_id, resource_id) FROM stdin;
    public          postgres    false    233   �Y                0    25122 	   resources 
   TABLE DATA           -   COPY public.resources (id, name) FROM stdin;
    public          postgres    false    219   �Y                0    25154    user_locations 
   TABLE DATA           W   COPY public.user_locations (id, user_id, location_id, named, worker_count) FROM stdin;
    public          postgres    false    225   �Y                 0    25112    users 
   TABLE DATA           J   COPY public.users (id, username, email, password, created_at) FROM stdin;
    public          postgres    false    217   �Y                0    25197    worker_activities 
   TABLE DATA           �   COPY public.worker_activities (id, worker_id, start_location_id, end_location_id, type, start_time, end_time, start_latitude, start_longitude, destination_latitude, destination_longitude) FROM stdin;
    public          postgres    false    231   <Z                0    25180    worker_events 
   TABLE DATA           @   COPY public.worker_events (id, worker_id, event_id) FROM stdin;
    public          postgres    false    229   YZ                0    25129    workers 
   TABLE DATA           �   COPY public.workers (id, user_id, religion, age, name, created_at, work_status, injured, strength, intelligence, faith) FROM stdin;
    public          postgres    false    221   vZ      "           0    0    events_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.events_id_seq', 1, false);
          public          postgres    false    226            #           0    0    locations_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.locations_id_seq', 3340, true);
          public          postgres    false    222            $           0    0    node_resources_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.node_resources_id_seq', 1, false);
          public          postgres    false    232            %           0    0    resources_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.resources_id_seq', 1, false);
          public          postgres    false    218            &           0    0    user_locations_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.user_locations_id_seq', 54, true);
          public          postgres    false    224            '           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    216            (           0    0    worker_activities_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.worker_activities_id_seq', 1, false);
          public          postgres    false    230            )           0    0    worker_events_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.worker_events_id_seq', 1, false);
          public          postgres    false    228            *           0    0    workers_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.workers_id_seq', 1, false);
          public          postgres    false    220            _           2606    25178    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    227            [           2606    25152    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    223            e           2606    25224 "   node_resources node_resources_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.node_resources DROP CONSTRAINT node_resources_pkey;
       public            postgres    false    233            W           2606    25127    resources resources_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.resources DROP CONSTRAINT resources_pkey;
       public            postgres    false    219            ]           2606    25159 "   user_locations user_locations_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.user_locations DROP CONSTRAINT user_locations_pkey;
       public            postgres    false    225            S           2606    25120    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            U           2606    25118    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            c           2606    25202 (   worker_activities worker_activities_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.worker_activities DROP CONSTRAINT worker_activities_pkey;
       public            postgres    false    231            a           2606    25185     worker_events worker_events_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.worker_events DROP CONSTRAINT worker_events_pkey;
       public            postgres    false    229            Y           2606    25137    workers workers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.workers DROP CONSTRAINT workers_pkey;
       public            postgres    false    221            n           2606    25225 /   node_resources node_resources_locations_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_locations_id_fkey FOREIGN KEY (locations_id) REFERENCES public.locations(id);
 Y   ALTER TABLE ONLY public.node_resources DROP CONSTRAINT node_resources_locations_id_fkey;
       public          postgres    false    223    233    4699            o           2606    25230 .   node_resources node_resources_resource_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);
 X   ALTER TABLE ONLY public.node_resources DROP CONSTRAINT node_resources_resource_id_fkey;
       public          postgres    false    219    233    4695            g           2606    25165 .   user_locations user_locations_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 X   ALTER TABLE ONLY public.user_locations DROP CONSTRAINT user_locations_location_id_fkey;
       public          postgres    false    223    225    4699            h           2606    25160 *   user_locations user_locations_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 T   ALTER TABLE ONLY public.user_locations DROP CONSTRAINT user_locations_user_id_fkey;
       public          postgres    false    225    217    4693            k           2606    25213 8   worker_activities worker_activities_end_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_end_location_id_fkey FOREIGN KEY (end_location_id) REFERENCES public.locations(id);
 b   ALTER TABLE ONLY public.worker_activities DROP CONSTRAINT worker_activities_end_location_id_fkey;
       public          postgres    false    4699    223    231            l           2606    25208 :   worker_activities worker_activities_start_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_start_location_id_fkey FOREIGN KEY (start_location_id) REFERENCES public.locations(id);
 d   ALTER TABLE ONLY public.worker_activities DROP CONSTRAINT worker_activities_start_location_id_fkey;
       public          postgres    false    4699    223    231            m           2606    25203 2   worker_activities worker_activities_worker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);
 \   ALTER TABLE ONLY public.worker_activities DROP CONSTRAINT worker_activities_worker_id_fkey;
       public          postgres    false    4697    221    231            i           2606    25191 )   worker_events worker_events_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);
 S   ALTER TABLE ONLY public.worker_events DROP CONSTRAINT worker_events_event_id_fkey;
       public          postgres    false    4703    229    227            j           2606    25186 *   worker_events worker_events_worker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);
 T   ALTER TABLE ONLY public.worker_events DROP CONSTRAINT worker_events_worker_id_fkey;
       public          postgres    false    229    221    4697            f           2606    25138    workers workers_user_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 F   ALTER TABLE ONLY public.workers DROP CONSTRAINT workers_user_id_fkey;
       public          postgres    false    4693    217    221            
      x^����� � �            x^��MwIҬ���
�z|,IJ%�(J*QUժ�t�L)�H��������sf1Vs��ͷ�ޛ����p777tv��j���'��p�MN��Ŭ��;EwUl�ʮ��t�uw�,���vW�oʓ���㦾.�WO�������a����d>�M:��ɀ?�{��㑣�#g���3��L�W�jY��7�����d0�i����n�'N����g����?�/����y�i�����b6v��b2�\�j��,=rp2��g���d8�O;WK~��z�����d:�:=�s2�\u�SѬ��Ho:=Y,:��Ʉ�,�fe|�A�}�ł/�;�y��{Y�S���sm����|08>X9�ی�'��x�9/��������F'��x��9��Q�C������;�ٞ�E�d4�/��g�Ѣ�jɉt�����h��'x,��Y第�W�;��)��OF��p�W���꾰�� ��~�d�s����sƎ����L�#ٟ, ��x��_��g����� �٧��d��ۛ������&,�|0��F�i��֔�z�=�6��x��=R#<t�'c���⮶�$���'��h��U�̵u����t��:��	���7֥��sxW�d�b�f��R��7���� qW���Eg�?��v���U��Z/� �>o���ɤ�������z'�����>�����7�v���w���9l�d�O�d��R.7�s���iLNFV�7>�{Q���b��a:Oc�>ߨ��_�>Wu���+֥�G퉚�O�2��s>��um]ͣ�T����������X�:jՌ�sB��&cr����;l�vCMI���pA��8_�뻿��d���`0?�������`�^�o}W���7J���5��;�9Iߘ8Pߚ/��^�d���I��������9,�aY�'�	�~�Kr�v>�ʉѣt�X��D�{r2��߿��ON�K:~������?$��ߑ�uܞ�_]I�`v2�B��}�-7�uq�<5%����G*9�|��5	���,���N�N�OY�'@�%�����9�}�*�)��Y�G�3$(�y����X?q�9M'��f0�+d��|�W`��l/��~��4��R��2�uH��9��iΓ���3�6����D�/lx�%�!�RQ|�8����t��=C�˓�x@��L����<��*���O��p�k:o
Rf��0 ��>:�g��ES����������{�?#��ӳ������I���.f���_�7��� �9"m�#�j?�;�j����^7������#s�;R�B9���Y֬p���*�S���K̢��]Y҇�l�oE16輫��u<IG��&�t��M�s�M�}4�_�ܞ�a��Ԭ����m�9�Ed)i�h<M9~�#pr�O��ycN�3�#U$�!9�)U>��j��'�8�r�p<�bS�yS���o7�p·��/�n��^K�c�sh��"����\,@��z\v|xG��c�:pm�]9�Iq�1��,Rx����󛳔�e�'���������=D������`��꩸]/J�8F��넬��%7�t_�]��8�gJ1��In7#��/�hgr�y]T�P�_�桸%u�=MEv�>>������껍�� ��?<����{d:c��U���ʛfYr�9�2q.a	tuxy�,�(�r��>+;�tb3���P$�S���h<v��.B�|��L)B��Řdd}gF�yJ���=��f'
�5^-G0n?<݅��Y��E�'�e맳pGЍK G�}0�sF�M;c1ɋ�����S(N�"�n
'�a�dǾ� 	��.t�ݟޞ���0[:��tA�vS9U,���-ǔ�S�8�N�_g���֪�	��/�Q5��M��z�E��%`�I!�����r��]τ�	aa��]VŃ��-�3Dn���\�G	c�����\��7�lwDL˲����R��� d(j7$-^�H�ِ,��9uz�6�w܉im�d)u�GU����Ӯ'iÔ��S9[p���U�`��Y����z�������V� >��ЀP�U<�f�ڬ,diў�yw�_\�&6&���%��E}�^��1K�A?���4ˆQ�w�eԑns:���"1������g~[����n�lg�-����%��Ԁ�:�:�iz�O�x�xL������s��2$l��f��_�?L�a�����V�W��Ȭ�?d@
Ndj��7�렟�&R�!��#:U� "`���O�R��NCA�Y ����O�������~I=�JD�v�#V��O�-�N��73"�[�w��΢fT�}��9]����K|$��B�h�fkj �'ۡ�9a���JT��]I �)�����:�}~�����T�Gh�z��?т򽮊j��~*w������#֒�����.�)�fSzd��\��R � %�h*���U�}[o�g���"�[��s�?媱�9���'�!TN�@�Z�g&�`�3u\/��f �ǃ/fU�@>��ڴ<��w���CD�ig@DJ��G�V.9H���i�C̦4�Ow+0+�:���� �J���Yl�M̷M7�P�v%�A�3��%�?��� Q6�pO�+��l1e7��^w�P�V�u����Aƃ���Ă5 ��|�n��b �9��삹����=T���f�P}!J��*o����A�?@���u�!Z�^W�߽D  �[LI]YQ
~%��<5O���[$�7M�����~�Z���3���IU
�2����� ZJV8Q[�`�j�G!�pk�Qx�*���x{"@���¥�ӱ�ܘ�� `h��ϕ\=ݮ�{5gA�T������^�3le��	5�@�YB�:���p_��p}&����T��ռ�������q����l�m�ǲ���i��m���Ay�_֜'U��zL����x��>q�]y{[8݈_����&��ɽ2�$��t����n� �D�K�j��]ϋ���DV�W�r�)Yy�ȯ�Ir�
�` ��]�`f����Ci�
�E%h�}t�e������bC�������5�3��Itw0@�l�=�e��:������):v��3#H��$<��EQ��*cG������T�Kc�kC�DgI5�5}�	dE���/b���y(�4*��M�`�d�� �w54���(rR�7��`���"��4�[籠7��BE	��Y��?q$D6aecU�@�}�<�m�~MBȀ=Ū��b2�$z3�����͊�ڄ�U�>=�^J�_����!.2�D�C�)�(=�����/��)-9�9�̪_���B5b�+Tž�;��E�����g��3�� �������p�(���}n{8��ΐ�Žђ���=`:_��$��{�H���C8�w�>ݣ�[i��đP��E�$J������X�l�ILR���/5Á��CTs�G��*�p>�)M� Vw���rD�#�i���*;Q� A�hS(C�|ǣX���7�X���\�m��/Ɲ�V�j�qp�`I���Jqb@N� H�#��o�xR��u�(��>Āh5�ѭ�[�w��y�Ė`� dN�)�'P1�t��r]�c=6K������X��[+&�̹����Ch��<�	���
��L�0"�?��%���bDX%\��Ag<l��D{�9�d�~�F���̎EDj����<���WYB)/��é���M=(	i�ސu� ����e��bA��f��ֺ 2�7�B�.'�MvV�ei�N��&�����[���	�w�5���D�/*�Ce�	��F��(��dc��$,+�m���q�G��o��Y�&�}/�=��Нrz�|��Ҍ<!�&R�����k}cݚz+��BHk��q��D�P65��q������۽���7g�R�E1�}U�6u�Pچ9���9�A�����{��j�,G��r���m�$�.~��W����p�j.��:�F���,�	��s�gA~F��?���R��+��"�����
�'�e��X~Ir�K'@	�h9ŔR�,I���h��    �s>Y�h���x���FVH��`��^2��|�Ģ�&_��,8]ڐ$����/H�U�@XLƌ��sD��oDT�?��G�u8V:A�g@~.S?7N�;L�*���%�,�&63��(aGd�S�������t�=b�{� �U��W�2�M���'����+�;g�����sYi���T�L�8�G>V7fH�k)���\�W.�uHe�^����q�E���R���f{�9���z����)cK�� ����m����iq+EB>��NWw�'�%����A�:�!��˾OdŻė��EKO��i)�3)������L��Q �7����%"����� E������"�M"�)�;��	�5�_�u���5�� ���
��vVirV�{�����q4	��������i��F����x��S)PX?�I0�q�J��Az�{e��/e"�7��\��S���gF�@քd��,m��Ü%�z1:O�a9#����%!��j�9 ����>D�������;�:��n$�|\�b2P����cev��Ȕ��[]�54��o�p]�-�b߲4�6%�0B�~�ꆜ$�]�<]i�a=�]C��.1J+(ELi�����5��V $漞�0Q$�h��n`h�����P{=e�aN�P�(��n�C�l��D��dfIuQ�u@R%�����	!ns(Aθ��ý/݈�8�)�^��?|��h�=�4ϒ��d\�_x�KN���U�` ��p�7�0L̉���,L����7���)%�!�W�0��9eBm]M{hdF:'���0�Mh4������0�&���f9�B	�)��k+�L�	Z���{r/G�2�WUi�)i�OD�+r��e��)z�V͓Q&bn@D4��D_ O��N� �vW��^�z����x3jj4d'#VZj%����A ���01((zQy#�aBg
�x��,����t��b���X�ǳ����*���A��=l6B|���\kBa+�~b��a�����R:�M'+��5)`P������u���:�LI�T	R'	�/TF����T���Di�D�A����TC�J����X�^���@�q�ŌM��=�i�.���O%_�?a*	w��;�6by� �V� 8Cq�;3��dk$m����':���@�!��R��Aɾ��� zz��$:�Q�Sh(�?k6��a�R�RH&���%L`O#+Ą���&B�����3i(U����S-#Pr�ɂ8 �M�G�fT
���d(i����2�l��oȴ�
�;J�]��a�Q��`W��,��$��@���9S9��Ea��r*��K�V��b�PL� �L��V�Υ'�~����NͲ�2�ÜH�W�&�C�l�2���?n}��Q4D#b�ن����|��L�x*�k)u>>�6�MA�(/����֗dU^��'TJ�r&���]��ݡ�d���+1J�)��I4��;3&�֒O$�)	�}���G"Q������D�'tX�6u}�z�Ћ�GA4��jJ<�(��2���J�6�^U��2;_*gS���B�&̢p�hb=3����>k��yU Q��*̿�Nh��'��|+�+�E���y$<B����Gw��ĥ�@����?�`pQ0�����B)=c�a>��=
�W��G�=�n쀁�=L�?��	Ĉ�tlN���9Y">�)�~8at��(($�͉�!o\��v�)���b�+��$w`r��($	�"���7Hl���q�P��[��WEs����9?��ۋgr6՟�Q��a���$�>�E�(h���x���
���P�	~�8�.�Q"P@q����!^�G������$y$�W����fDc}���R��"��I ����VF}B�q�+��=A�����'@������=��^c^�##�g-D�`jx�|��M��~�-3��[�g���
w�I�YN�*En��.�a� X�T�]%$Qs1R�� �?�C���iQC��^:I�(�'z ��F��u�#�+o�X�+c�'�H�����\��eݺ=!�rtr�G��.�QF���S7��$#r��O�i0Dx���5�5.��q��F9�B#�1!�����x�kf�IӖ�&��L����!4�����P�!{^�?7K:JNE"��秾e�Sao�G��6υ������ҙz������;��
�8=�3	æ�Ń�-�~�����T(}�hx��2��6�Q�E�.-'�I8��e&t�F��Ɉ@=�S���9�J�!;���y��B�"B
���~���$l(�1z�4�y��Ǧ '��;���&�<���B� Eݬ-VR��%�Y�%�8�����R6d����������z�D���=y�(5�	�K�昔�ݫI��/��eyc�.�o�(�!��? bՍWۍ2D`%�&M�K�,'�?^�pMrj�Z"��4VXN쉞:���k����l����T��8�+�r'@�g�[ܵ��ͨ��)�$�*;�%VwW�"�w��Ή��FP�cha^MB\����������3��b{H	�c	�K<��ꝩ�C[ =S�}ޓ`2��~�J�G�����x��G��=���Ї�u�Bq�yH1�$.Ѭ�YeXƒ��bI}�(��x�F��UHK	�\XY3�ː����{��]m?-��%h�Il҄z�e���m/~�̪��2�(�M�O� ]�3���q sR��#AA��������ZZ]����9&͖��o��"�o+�n�&t'�d�:AZC���h�	ҍh�Xa�Y����y|{d������TV9��	��s����OO��Br��AC�?����c�+3I�~���q=�A�&۱9��LgB��j�1mu��^r��L�Ĭ3�h�T�6a�]��{�bpw�3ʙ�<{]ѥA�MUA2�T?��Z�t��2�1��\cBm�����c�|d�D�x��n��Ŷ�GygIj�2+�)G^2ЌK����ˮ�|�jFb,�;`3X�yw~�3�6ee�V7�}a�@�-B�s`F��T@��bYfi=�_ŤȀ��yĕٹ�2N"3��P�������Qi=3����}*Z�������t䘖L�# L���Ы]����2R�y:���D�%����IdN:����暴~E���w2N�"{�F4V�ʫ�5艷�3R <����� o����i��X�@����NzIf�U3p���	ِ/R6z�.�9��4q.�'��O��֗O���(���,Oa�.��/����=]Rr}�TnvV�(�"z�m��ǔ1�0��v']� ,F�:#���|)�� �c�U��Z�k�s{�O� ȁif?Z������0�p3f�Ȫ ���~Y��Z����Ts��CJh,�̓�tH�9r���z���^2#�a��`E�������A�1XO��y�l9�7��vdZ����L�@z�"rT��N����H�Q(e�b�����;�s����$ȳv�����+���G�(�����x���Y�ؖ��8%b��7����OHxAs܉�"ڌe�!�ZAfq*�Bs�ߛPY �~m�P��Qi��ִ�SA��A�f�?�����S Dm(�F=�V�2�IDhU�|�I�Yv:܅�v{Q��f����z&�D��M){4#�#غTׅ�y���}�i�S��!�����-$[�xB�JMc<T�����j�J`DȤ�>�rB��[3��&���_�c����D�@��B��i���1��e�X�����%d��m�_]l�����0!�%>�
��_(��q�r_Qh �7�wjJªe������Z
菏ަz����` �7�w���Kf7?��TI}%)���-��A��1	�J @��މ��(��ȱ*>]'�RMY	�8�$��Y�5{γ5wqA��n�f{A�>�u�Gj�L�ߝ�y���l�P��'���ٟ���n��m�����`4�͇�*؞k�&�)D���)��UA�e�_�[���)J���_��Iogd	�� [����`	�7J"M��s�2�>��^�0��X�X�*��䥄*>�t�P�ןq�    L��	C�E���Z��2��Ufjʲh0ej��i����5�`{"3��ܵ��J�E�s��3Y�<y%�%fjB��||:S�_qE;�q�K��S��]q�v>n��[��%]�X�ъ�j�b���ݨsi�
�����!�a��7֜�=JR.��7����2%-�sp g2a �&҄�wYa��RwP���aÌ3�	�㤃(-�	���(]ƶ/� `�|�_(����Ƨ��=x�fi� ����`T񧵜/$��ƳxG�"GH���g���9���8q�Tƙ���CW�fܟ�7S |�}E@c���A�؜�J�}.�(7��L���wfXN	u�#��R�gk5Ob�����2iݟ-�GK?R`�a=��{	,z���� K���p�	��l����Z�f�f��7��z5�+�+�'�DOd0��zR�� �y��v����.�:�"�KX	@��ጝTo�.�����I��4t�MFD	�UmO�lh5>�uJ�{Z�}"���E�����2��у�j�.0�S�ۅO���3z����O��4��s�ZY2��D�`&��vXP�?�z����V���0���CD,eXa��uqo�f �$l~||��U#�=�.�#\@�����T�韪��M�C�����%�7N��	ٞz�2J� �}�߀v1&,ƜB�'��9�J8���5d�ܣCq�Y����	v��4\��{�S$� �T�����zE�P��R�,o;Xu�'C��YQ<cR,DǑ`/�H���Ka���7�����Hd� 4��Ƥ-�ÜMd�/AW���~7�ʬ���q"R���G�G�	x(Z�Q���%�A:(���U��t[��2���B��e�B����(���2��Dphd>i�B��H�!5�L2lݹ��c&�'����s�7��G1��"�$�|(���ș�?�Q����5,*�P%.EؓK�A#hA(�� ��aF� IBo���VAv-!2��ĥ�GE�7�t>�?�-ܤ��&B�;�1�wV���G��v��d�y%r�v�̬q�R��ڂ�L���N�kK��������X%c)2�ۥ2�/��2�!LIĎ�	��,X�]T~�A *�G�6ܙ+1)�.�#NO�
T�+d��'	G>�r��W�2'�PR��B?��
��wO^ə�d�ܪ�'�&��*k$6�.	��m�;kx ��Tr�u��G��F���P���\�z.R-9&Y4@���ҧ�Dg�9����\��T8�I��M�����B���S��T�֏�YVHL
Y?�F����my���IbQ�CY�Z"iK����2�S�c��'"rY�\��@��5#<yɤ�KiBנ�޺J��ĥT�Wf-ux:�_��M�������EC$4��������*�Ru��҆��/���IN��8B��>Jz޶sU���-;�=_^=�����VBqd�:$��OTFUN��1uh�O�z�.��C"���Y��I�9!՚�9��'��͸2W�N0&*;���P���$fĠ�.�~2��h�TR��65�ޅ�3�g�Sdh��s�C=
�W��ϸIԑ����fW���W����y�,�y����$�Pc ��t�S��VWlc�)NH�-�K��Z_d(���f#ۖ*�y�T$;1��掺 S�7BbtP]5ݧ�uit�J[���O�Y'��'���>���������,��a]>U���U����K��B��� �e��M�'�B�^a�@o~J�Ł ��9^*�a��\;,E{L�Yg6s� ��rWO:��,%�4%�)43�d�2Ʌ�>0��~&��:��9���O���i=,�ٳ��u���q~w�RL%���K��e�呉Mѓ0��$xտ@�-�SRz�����&�����#Cin
�v~�A\;��ģ�@
~4�X������~m�~�O�,_��=�`Л��$�S��#�S7� �kO�{*��d�Mٯ���	D�m���F=z潨N��)���������'Wjh���Τ�3(ρ��{�E�d���F�ARv*A�R٢�p~|�?�HZ_lI�I��js�LL�=+K�ӦT��g=��_�J1���X~�Ӻ
��0���\k��HI̊��s���Nm+p�ͪ����}��bs�� �|nL�Adď@ge��l〤����гvA�u��,�k���D��ͽ% /k댮�e��U����jaĚ �3���ĳ���@bL�A��RĐ��)� �#K/�p?�05�;%��\�d��{�lV�_x�I�/�Bƥ�����Lr4�f��)1?J���/�)����h�h�A������f��(���k�.�{�����Z|��u�E��T�����V0��8�BZ6��gR������s9
Fk=4YԮ�a&�3��F7�*j�k|����ug��Q�P�lwA�R�.�p�@Ԭ&�$��@�A'W�f|���ץ��V���s����j2�~dv����>�D�P[N�����]�]� �L�B�'=�@U�����K�
��������'�er3N*p�({�:�g��K���Iֵ��6��2Lꪰڨ�ܨCN:����R��Y�^T�O�^r$�{U�,�%)�v��Ħ��*7���P_S2�'�[���#giQ�kz>%�k�FHt
���)���Ͱ�`����������=@����������LN"`�L��NWݳb�)��$�U�R�TF��L�V65��4�;`�i��
{)�G7IĊ�|�T�)�R��f��� �Q��":��y��<��Mi�k�b!�i��e�Bں��pK&�o5���Q�����+�⬯��`�m�ٚ�E�T@>6)%!�
vޏO���v�`!������8�`�d��Ga�C�V��)zh��L�(E߿����ܰ�O-V,��CS����ʜN�~p6h��Pn��9P��a^����w3�d)$�lͅ�]OQ�f�؟)B
�I����Q)���ǈ~m4���Ϣ�/��Mx�&��4�p~��"��o����2E�����7��$=�$*�1���0��������0��V`�� �W������'���%�;�%������&*��9ZJ1�Wc7|�ɭ�I�i�ߡ�����5��^e!ӗc3E��^/D��V�꟥�ۧ��>c699�=��'m�#�C=�}�3Z��SV�a�	S%����L2}���!k/Rpo��p ��*�����ѱ�зa5�W����L��o����((g�E�l%�rh���]P�O��+�N�ƨp���gRH�ņY�K"�&�\�B�Nʑ�����rkXL�"h��y�>��~���2��Yj�ܫ�ڈ��tr ���5��z�X��w��P^߾�Ng���%�L51ZY}�ђ�"��P���be�D� ��g
���)�?PL���.d�;����iΪ ���c^C\_I�ݜ�a�t�T��`���C��#v�J�=��5j��T�_���7M�
�m� U�:��l�l��J�)�l<8�a��7�i�j~ZlG]�-�&�;)�L'����<X�B�|5Q�ح��z���D�`�~&v�0pE�?�|U=zkP�R���y伣
H�@���V&��ʃ"�b<WY�+8��t�t��f@�MO���9g��6���2�)uV�Q)QZ��&ZK�T��(�9F�D�f6ֻ�BW�v�ؿX&�{a78'+Q+��.$�'%I��|(�ߨ�@I�Q�m@����VC��Oֵ��
)�Q�t�;��VV���T��	ò]��w哹���
7]LB��N�{[{�'sƁ�(�C*`��8�i��ɩ��I��+����d���p�g4����G�ȯ{�� ���6X�T�$+D~��_`��B���������ai9��~���� <�
h><�z��ms���sD�bJ�,�J��������]�BR�Ī�W�E�<�=G���7ί[!��m����@�h�4j��r	��N}���\�e���%t�9G�UmQ�Dy:��RP[�������k�a�d+��(iaŴ������dm����tH9�H?�г�d    �<4�����*�
�ſ����iK�O�Ӡh��K�t��i��!3����q�����	-(Y㉧���x�&���/�_�D�Qu������C�q*��"�:�*���.h�}_ܗ�@��|S�D������`MhNs������Q��+KLJ�ǃO�[���*C!6t�=�O�e%0�u�|�m+�83��)2%P�G��%�����s&VE�=�쟜?3�RY����˰o'HL��R-`�`�dU�Gꤴ���VI܊9�|w�u@�с�i�:��XA�o�<���8��O�OOU���E���=�M6l�9�Tl�l��UD�r@������B��q���.����n]*��cϴ��H�Ԁ
ȍ�ľ_�}�B�G>�2�y}����+��
y��͆��0���+���  $ܸ~_m�b2��`5礮��āVwƢ>�;j���(��
$��V'PevlR�P��*E�]��@1y�R�C�*�7���3��R�S#����z���$�'[�o��FiW�pn�D�U�Q�Xh��'ſ���$���R|#��/~X�~�N�?uB���]3i�xQ�F�@��Jy���&��P�C�K>�
K���4'47O�P�~����(zDO���	�����T��?D"ʄ�(.�8��`���L
�<����Q����/��)M��2�%r��Bb��.Z&��ğXU(=��!1�'�>�v�4((��A畇�j����L������ʔ��RZ�i"N�']��%C}�����!{�;�?�]����$?�H��=!{J���?Ս77<̈́(�>d̲D�E������]���f����rQC��DC����e�^{R3�2�7	��D�@m3���D���ś��e���[CnU��e�%�7K$	�xƎQrF�����6O��dMj�H�Ū����[� 
Ǥ��Fہi[��0��9�`��>9��`�s�}�ϫ�0w��,�$��X����C@���Z�[����и�����(w�;%�%��Bwg�^q_���M�]�A��ıψ"az/�
�7 1˹�i<���6O�,��on����?�ʶӸݥ�y��	�����(�t>���uS3����!��>���|L�:}�M�5��͒�;��Å>T�a�'�o��*> ���JF�l��_8��-	'�Y?;��D�S�?<9^Yѧ�	WU��&�y�����	d�f�;�I���������N����.���: w�gjYJy��i�U��b�ʵ��\����wl��R8���Z%��g��2h�"�G�M	�f�d�
�i�ی-�a��5�s����'�=�\�b�Q�oW�5��N�-��޸t1�������&�����#��c3�D�4�b�į�&7X����PW��ץ]:n$
GR����SN+S,��l�� �YΒ '$��@�]J�w�i��p��Kw4�Fo��y���T�}�������"�Fqщ�����Pv�ʪ�����9OVs�r��Z�R�Y�4q$�f�
gF��B��ߡ5���i{�ĽS�#ɭr�9f��ҵ����%��`IBJ��R	"�E>��0=�e!f���tmT�A�t���4,y^<�ު&�)E����` 1��� �"����H�b���̠)�4K4���E�� Y#��K�gu�)P����^�`�ொ��޳o�%���%�4RV���#�KU���c�- ��-A�j�DMZ$J�>�]��ֺHsO)"˴\�nhYv�;�%�]"�0"�y�o�P���N.��<�Y���R-w+��'9�J��@}!�o��zJ�¥�'�zF.�D��̎�����yE����p����[��G�Gݢ��w��D�=�x�w��!�5h6bD^o�n����`Q�g��C $Ɛ��3:�u��K�΅�+O��ۋ��GF����@9�U�Sdcuʔ��>�a.+�g	��QNj>t��w�7#�e��hϘb �Lᱫ[���
`���rl%.�Y��X�֍�(Ph�Dko籦��q\礵��[ �%��c��s�Yg]3�	rU�DF�~��x[ZTY�C��\IX���A�ϸB{!6��'"��T��b������%�DOv�ڰ�`�ͷ)).,���K�Z�K�X�G���E���Tƕ N�P�+*U�_�$�F���0;�����^a���m�g�A�3U�F/�[{�P]zk"KH >X��.�����"��q�ߚt���7� R����~S�����$:&b`�ӐI�aZ�S�{�t�x�I�4�4!�)�"Ywl�8��%����@�k����ɒwv�|����:;��Ż�,G��a¿�=bCI*��P;߮�Yb �
��d簐��)=<˭<`��p��������!�a��[�4+(��U jΞM��9@�Ò�Gh�,s�hz� �Z��\y��V�W;���o��'�hǭ�DĈ=����ʋ։B!�y����ؿoj�]��):"�c�<(`B�����ـ/X�:�����-��2�Ģ��Ji�� ,��Qch��ҟˮ�#-
؋js�8��qV-'13DMeg��㜃\���I�Q��a���I��(̀�� 5��[Rvq����.b��պz����>�`k���F��f/ȑ���㑀'KƞFZ�A�����Xc�#���q��܀�%�8���w��S�V���0��e��Ga4���8M-,F_缼n��4W�`=CjH4q��}H�4�Znw�F�xY� H��X�O9Ot
�J5Q�9fꊡÝ�7�����Kԗ�K\r�4c���)-q�y�;`5�:�DC��n���0�)�|)�f�%m1i�[�Ĳ/s��T�_h�"�礫r�;<���UZf���^�7�t'HM��E�Ü?�lJ�>?Le��x�S���TtD㼠#v_��l�i}�cL��v��S�{�3�c�iyYk}9��PC�Ϣ�����f�����k}W�֋f�K�K�Q`�w��'�D��Gק��X�+�l�s�#�YҤC��{��PB��#O}�9_I�IsO�+�I�m�\ӧM���Z�+�Y���^�Β��C՛�m�7O� �_b&mK&��o��YO����2S��D4�JA�zd��	�=r3ј�k�nWVSX:9�32���!{'"����"}k�Q�y\�o��iz�^BH�.���(�[�W�,���i�ÿ_}�dK�U
a)Ʉ�d��2�w��meH��D��6*M~}�YTdvu��fgE��tA_\�vb֫�{Y�l���AJ���ҟE��g��8��I!S2�2��Nk�\�B4.l������'S�p��h������Q���)|_�*���ܷ)��Z
)�N	`ʟݏ�UI�uvYf��Bcʳ9�_�]�?�-�)T@h1X�o3�r;�A��X(�A��z�B���!�X??SU��R�e������wH
[���G����h�8;K>jÂlNeT����'����#����tf���8)Y�:Yj�M3��1��p���*He���uom�	<�4í�� E��&J2jC���5��2�Ԅ�-l��Ǖw�3�Ŕ���4�G�k�9W��[��<s �7<�S��EC��H��Z�Ꚗ��auI��0m����*f�}^ZiԏS�oInM�jZ�o$�"b$�0䡟(s��93ztx1kU2Ol+��G�s�;C���*SE�Yn,19i�,gRc��Ƚ�3p���^�N�J�h�rDSꬾ�{����	ڢ��E�ysM���������b�v�3#�!4��d�o�c���1=b�Ps#���{���縳d扚A��	�ۓ=���2Rp|Q�E��g�5�g�ʌvK��]a����u�I�x0�')C���uOH��V�d�4�о�.���Q'mF����I�x"�j�Y��;x�zM��
�D� ��Dj�A{u��:
#8�.'�E�Ɏ�^�V�t$=�y��'9��#��D�C~A�������V���k�����m���������2�3.�q�k�U�CJ��H�Ҩ��5ޯos#�'�(	�^��=+��    O��칦n5�'�]�3)�t+�0Qs���H��АD�:N�H��b4�<&YC��t+x[Q�yWjY��՝�쐜�1XSpt�A���`[-C �<�)	9[X�k��vm[�0o#�@�����5J��tgc%Z�fp���1C׽"�����f����8E@IuyɈ<��yF��˽ �=��5���&f�l��`�ʰ���|�6ͣ١H��*����X�7���W�ep��K��a�{��~澺�bV�e��"�(�o��4`��#�PE���'��2��3Δ�X�+:>ilI�YN&g�	%��(��w�z׷����J�Bo4�����f+�U�er?�x�P�4C�$�Fs�H.2MB����b�w���C.�����z{_m˥%?.ݺ�z�y{7[U0x>x[6�n��b��������'6;�X�M�s��.����p�L�BP@�c�"]�O�W�%R@)Y�B?]��ْ�s��D͘�a�����wW�e\-�KL{�pD��ʁ2JƠ/QHS�k1_)	�ҕ��1%M�{�+��
5�p� �C$p�R"g`�����b�k��b�P7^�!4��պ�&?~yBm�:��ש:�'�S�^�%)=��E&w���&��0Ĵa��ܭ4S@љ
肥��������yZͰE�����n'�h���T���_���9̣-�b�~��3��RQ�����Jy{�R\��N�؞ �"3|�=�d\I'V��H������Qrm9f'^����qI۰���yy��^H�q�t~]��%�'Iԋp�P�'kU�w�7(BY�lO�d������-I�-;U��a�	��Q��
���c��ݍdM�\�y�~~%��qJG���ɇ@Y��hV��_����=61��v�"�3�%m�'4��2��$x�I�"���8iF�)�GS;��){��yk%��^�O�Ϭ槪�����=�{hE͌de���W�~��Ɖb�ΟkU��)�3�� Gm�?�,�q,�JC�=v�*��G�P�t��y;w���V�2��B����.�B�t"p��V�~*�89�@��h	9�¤�#��v���ʤb����O���k\�4�4��ނN�;tm���W6-rp �G��O� %���-ԙ�`�W������͔-�Da��BJ��K�����rE�&|���Yk$b�@b�{�[qZ`X����P�S�1�՟�q�i�n~�^�(�.���f�I�B��{@B�.Bj�ں��"|iU��G��ܬ��m������Lるk���؋
Kk��z��O�˶Z��)���m�i��j�l!�vF���Of合�4IҋV���E#�w��|-ݯ��`�z�u����<����3/ų�X����V3cV���N��������zRZ̠"Y�r^I��+�2℮����A�a�~l�����}_
x���O�e�	�84��.�|A��62��5�+�i�a0�h��O�t�U��ʩ3%4j�N��dz�����ŨѸA�WK2��|�u)Ё�I�P^d��
.z�V՗���x��Ԃ U<Xpʐ��Fw�Ov+��!����)��uNy�+E ��_�}u�L��G�������c.,�|�<�4d�6��wx�1|A�J�����Sq��^L�i�#�X����,��i�2̦�.�)W�[�� �Y#�r�i#6�N\���3�KY�:��E&g!�S�&���S�Vr�IZ��q	h�!^�S��{��PW��XЖI[$o$�"�\v)��=��+�*2C:vg�Fz〞�&�}@tj�1���vɭh�\�B�q��MEP���і'������JbK�V�꩛��kX�{���=���אc�N��sg���8�6dV�J@K�a|�������BŔ�h!�H��XT��<���,m��!֏4����T�ѝ�Q*���զ����O}\Ͳ,yS�NR4���9j/K|
�='���rl맷W���}%�}B�E���L�B�>m����&OW���dC��zیȩ�h�H��ȍ���%��u�3�PIѼ�<7��
��ƅ$��Cs�j%��Mym��6����$��,*�;}��_bRH�a&�,X����m�����R�c�U0�-��C���
U�Ғq31(�8�Ȇƭ�P�[��Eơ��%QZV�r>�A)�#���J�D�5�O�5��X �z�>�
�3�ɽ%��t�"�Y�T����­������%��M�	�0�".%���Mq����I�BȚ�Δ�P����U^$�#���.g�Ҳ��Y!7��NvT4e�b����ԎC�g�xE��?Q�3�S��6��"�'�G4�W�WR���if2e.C=��:�{�S�Z(�R�Ҁ䔮��"�(('����Pb�-�L�"�i4�?A�qz�7-�cJ),4dݤC"��~�_H�uO'�@�U����>�޽S^���Y���ʦ� \�)��}q��@!<6-�v6�Z�C�I�x5h�K�3X��OH�c]�}�q6>n��4_;́P����� �I��m��C�s�r�ޒ:L�#b)(���
���HfÊ��COEs�u�O���p����F��e �����*ۖ��bCi�Kxf6�A��X{.ch�?�3o`����u
�j�AEd��ĺ�Q��z�p!�W���1���8g�Q�4c#}6x�@�@B����۫�ҹ�\�Bz�brt%N�gcj����hA���=��$(xw�G��%�	)D�s(�������w(�G��aL�h�%+��oƮ�ϖ`x���Z	����|7�/止�!ڈn6��Վ������-J�-��� Hp_X��'DcA}(���MA��`j����P��W<�
���{�L�הKW,Ӟ
Y�s4�oqW�~�~0y��!���$�.� .�̀v;���iR�,A�(�,Ђ
�/�e����f-#��1,l��nn0��,����(���V�g�cӓ��o���F���yh��KaY�T�ñ���B���n�;(�"u<O��������� �dX�yi;Bt��i3'B{�������pQ�{��:8�[�����o��|�"W���j�H����@���i1�0ŧ0߶K�5�Ȁx�#|�A�(M��U_d�XsGk2�ާk���¾�u�e�3�:g��|Dȋ-���#f�ۉX��T�-�S�{x+��MS@/xO	��Be4�ﹹ�L7$����pn��&�מ1 �>ڈ"1��y��rܔyd{� ��R��
@�ei�<5)� �e�~Հ��j]5N��g���7������B!���NC��ɀ�y,���k�a��34hȠ���v����~nJ��L�섹���ۀa&�7���7�`�
R=�衑m"��6���D.��$"�L�����h�q"g�m"g� �
�= ў���&�����Nq�X�e������x��]%Ϣ�	ᛲ�ܕ�/�%OΥݙHB�Dc��5���}��Q#[�� 1v�a��O��w"m0�U<S�]��S�x�?/�e�gq+tA��c�]�%�F,��u���+�4��z��r�oB�U�;�pJ��O�ĝ���c3Y���eH��k=�& u��#o2��i񚳴<��n.#��4`�w�u��ˏ_#T$���jB9s�R��bdfFB�A�)�g]���3�aE�����Ɗ�.�߳����'+��<���C�L|ӄ]��l�rh(4$מ[B�\�ؽu3�Q�Se���gI�Kj�[��b��f.B��쳬�7�hf�=>��'ju^��w�9)�ۄzD�$�ډWދ׼��%��힀��O�>��\H�M�F�uՍƆ��\"C�1���#Θ3f
F !��ĳ(ͭ�6��^oʙ�{��.�3�,�^�ٞ:�D!�K�N6q��V�<X-�b�d�Ix�pk��!\��/aq#�<	��&�bX"qHsR5#?�zd4����NJ�^�\=VB����o�ȕ�8[�?�%tɘ)��R!�Cd�fОR�!����kk��Gf&�b]i�\�+Qe���"������#lʴY�E׳�w�K�@f���gJ0��*�c��D�    �Ds4�	���g������T���=k��<W��?�nL�=�^���j�ԭ�!�@NVx����x�C� <C��n�,�2�G����	/��^�y�����,�Vf��#vkv�2��a(ʣ�@�i_P(-@����(F�S�IH@{nj
�X1�[Y��w���i��|�:Qr�@�����]y���AR�Z`c@ !P�i���y��-;�6�z����#pW?{�J��`��-=�HNo�7�ր���>���H���e{{*�xC�-��2��L�膲�YEƂ���I���k��Ns� U�Ɗ�.�Dp��s�����4"��k]���(Q0O��t�������/i:لK撀��*r��kS�-&�C�G����c?R�Z�g�W�g#h��Zj����b��\��ANG�2��A�!#�k'�c��iPt"n�7h�ܛ��<72iJ����~�8�V��);~�Ex��/^CЅ��X(/��\I��`k@���Z���r6^�'�h�H"������
I\C��}mb��������LF���bQ�%{��{3d1_: ��)Q���7D^��iN;fqFJ��4���gjO��"�k�Fu���5zsq����
��UnO�˾ݣ^!T��!3����V�u
�̔P&�/�jEa�7w��Ld�# 1��^*̞O�*��H.D���$��������|��A��{�A!�Yx��A"u@J�<Jbb����AH�¤���"Q��v�at��
2>�ԉ�l
$H�"f�Եw"r�y�q�H[��ß���!��W��HR8H܁"�zUHG�t}�����/+���nm(���B���%�=4HW0�nX
�E�~�K]�
�~�X-�it���#�;�1��A)钜�l��a�}��0�)��z,�P
��X����+�<Q�_{y�93��4[�x�����~��-�!����K%�m{����|����s�m�5�G��m@�g��Π\J��ŚD�@�a:#�Q���4��j�P����� $5[������
�fVt��I���3,�,���n�մ^6�w(�K���D6����[d�P^��<�"^ν)�8$Ƈ@@pjIYB�^��S��+�2�͎��h2@T�H#�e�����U�ӝ�$�U@�S<��s�/��N��MGV��e�3�Wv,�AiBL�x�4� �������E�R_�"Z����;�\2H'Rc'r���N�[�� �`��&5�oe�P��g �*�,���p�58�#_��	c1=a���}J��$���6�*����w�@�.k�� � a-%������h��/���B��N�5q�T&s��R�i�V�S��BY�,)���'�I�v��M���i�u��I�����8L��U)W7ͽǌT�1W�k襯���dY�ZIU�����D��/�o{� ��A��1�W�X&:<���$,�p�.�	o��.�D$w<�!�P��@m�ߣ����lo��⁞mx����Ѳc=��B32��ď��V��VH�P� �12���kH�^R���Њ��8�ȱ)��[���%�"�~ad���v9�oBh'�L�c{�p���v���l�i#6RD��"�|n*��X�,wB�0;Z�q�~#����a��<O���_�b*��@�����+���
^�&\�`��٠�$$gFo�+�8��H��{�����H�����C��yT���B1O�h����R��e�*T<�I����*�M*a�����Z��� Auf""�^2��!6�^��( �p���t5��L��r�vp{�`�B:�)��+�ԧ�n֣3:��Ci�I�bDO�6�̇������z�3�������:h�Q��o&�E�҅M	d�^�|���
�B�f�$A���d��M��/����������Р���=�)��D܉<�0n�r�����d:3��h	���p�8�Τ|3q�j�@
�P�f#���^@����wK�F
�_�{��7H�yQ�<�P$���w��%M��D���W9��՛� �D� ��!8"q�fZ�\���:��$O�2�`���ƞ��Ub} �@� �#md<ae�<��	o<��0�U��sֵ��'�ǌ�Wm^9����z;4d+tgZ����g#sJ#�DR8�2b�4�n��3˝��!eZ~�5�+�����9�)�88# �N��iċ�W֗�f��9v�t?��ZZ�<5�����NS�@��T9��Xd��&=��x�Kڤ� �P:�l�-p����W��9T�_Z	�@�M۪��ժ�S�0]KV (���Bk�Gk�i�@�ժ~&�{[�<�{�}^��P і��~��?��k��yH9o�q�s�v���D��ߴ�jï���(-�v���S��Y���'�>|J���y�����é�@�VXY�&5�g
,�V�2@f�53�T�vتp���$9�,7Llq]��	b�����'���1�!�J��Ҵ[��0c}H�K�x�I�����qO���N��@�\��Bnd�2��/�ŭj��$���z|�,�c�q?� ��':7��߽���=Jt�M�����qժ��h��V�̂U��/���g��4L�Q��<��m��׻���y-�an�"�' �١�1D�p�,��@�"�&p��_���G�;��6�>z�~�,����S�8��� ���0��	h�Y�BģL^��ۻV����q�+��<�o�����(��{���^X�Z��\�"��I�D�`��C;����%Y�����,w}���=c��K����C�W�dfMT��w��P�t��`0Fb-HJ(��]�u���	��>���^�҂.�^�WBP�zD����.��ݹ�i��n��Q��~w�s�ߵ��ab���]�������nW�Xc(�Lდ���RC�Њ�^2rKϔ�7kD��Ϙ����Wf"K?Y#?Q�Z;#�AtIL�,�U�Z�����Y�����/e9��KJ2/(��PܛR�eo(#,$x�X���@�	��<�x����ʨL�F���T;�\}����s�K2���B�a�C��X6�]Eg�\k�e���	��if�R�ʁ@ΏBz��X*?8�rS�EЍ����[�?�f��=$&5�`-n�����qD�i&$�C1���q��-�f\`�hIb
�/����MT�+�����1�0���7�U�;L�ԂYVVJk�l�M��01<h�!=!䟽􀥩��Y#L:O\Z�H�k�cU�?"��D��oI�Zw�@���{�49�7�S�X�Տq��J���J�dr,�K�M�y��4=�I��K�G�q#�"`&�AJ�w��i�մ-�V�����tGحb�jjl�|��T�XU�T8y����[�j����'3��W�}Vkk%B�����ЌLN�\L��"�p�\{�rZ�c[�{�-Ak��s����=�<�9�d8�j'q<ztqgҿ�*a����6o��Hw-D�Ց�|B?l�{j��H[��O�|��F���D쐁h�ǝ��/��;T<e9`"�X|.�֨�xo��)TU	u�x(i�w�أ�s��'�pP;�gT��N��A�p��D� �'�\�2���Ce�FQK�ZQ�>M"q���N*f@5��
���ۻ��������k���w�`D�>A3�u�h�X�:j��l�!�*d��KT�4+�� ����3�M<Y=�^aK��Lw��Q&?T�*�4/3ґ8�B�����{�Z�#����4�%U�6��UR�(s�p��T��"���P�.�o��o�}S�Y�Pa^���Ow�/��n�0�74��-F�w���U��ܦ��0�����K�I�W��ر�א�OX��xe9�1��bV�N;��$j��V�{a!�7d/�ib���e*"���H��n8p�f�I�.��5�]w^��Ҩ�B�]�o%/Q���̪E�� ���ί��Zy�a&�1#�V�퉚��$13�L<*Žfё��	���)�%Ү�̭�����AX�h�UM���"��O��jD���^��ɮ��    [�ˊ[��A���3$�F�₉R�.;Oe:=�dI5b҆�&��ffڣ�� m����"]\�p��P����]e������jz#m)KX����z�-' �ā' zoeӈ� {&_;��@�7�r��$Ft(@76%��{�|@ْhX�c��uä�Ã��<��4���J]{]Yg@>B˙>U��D"�]g~�4�)-�98�4�iV]5�Mi�����1�c+� ���m*���Y������1�S���L3����� �C�U����m�Cq�[�8c�|�u��	������an����uG�-}��:D_��g�ESyR����2`[i�gt���W˚�ph|F��y�X��Y%���E��x"4�e��ޕ���>���L��ֽ>�tF~5�|0aҶ:X$Џ
�a��!��ɊHM�=�q�E�
C1��'�>�o󆮄{�f��,�A��05�HG9uC�)�M��!p�$Tt$]�t!E�"����Y��4q�?� �.�]J�(�6d�-(�
�H[[x�r��랒8"��1�[hV�h{{ $�e(������K�ڬi��n�����)hmRf���>߈n�==�0�1+�J�{�5�$�MD'6����5km�P�e������d��E�	t��H���1藉j����ٕu��G�n�W���1G��A��(r�@�>���o�ץ�CeJ��5��|��z[+C�2��BG�.��eaa� M9V������R饮�>|�ٞt'%�?��7/Aiiq:�</>~̹Y+��ph|;K�3fJ?�	P�DȠ�˄W��)"q�E����©�Bmo*}CRL\Qdm3���<���v�1F�d�K��}���'F��*(q2��0!�t���: �gQ"��,���"b�G��(��Ȅ��m����T�WޭM�PZ�FbchRHnt�A_�%��,�E3畃4$�(0�ح��?12zbM�E٣1�dǿpЌ���@O����	{SM�D� �;1�FW��@���てO��P����W\�x%y�s`g���9ڭ���s�$��ԝ�n�P�E֞�m�S饆%�t�l�)2»��=�3Ś�9�F�h,(Wo�aV��j�~�E��i��2LVV/*4m�G�T7���Jœ5��o�@"f��i(J�-�
;��¯�9C���Gk)<O�����C�B�f�F��g�i��xBFĐ�/C/��x���{�dU^oR���Q]�H�n�2�?+|�����D��&s�{tN����Dm����.=��Q�b@�Buh/( +�p��"��d^���
��cͣI9�2:p���Oj=x.��pՄϵ}�&b�J��5R��W<5��M����P�ϰ�5ճ(��6xG"ci�����h� ���Wt��2�#��n{����-��F���˘@pLc�{�i�1"��mw��jY*bh�G�;gQ#~:�\\Dތ	"�ߋ�L���!k�ɦRQ��L��Q?�{!'16�L&1��G�o���J�=%1̗������
c���MN�xB���lF%���!�؊���8��z͘���c�"�=��C��X��F"g,�b(J^a$��j뢐1�_?�Ф~u�J��Y�A扚�d.�:��P&���r���NA+��8J4ZɡׯFR�3��׎KC]>�a���4�9����Z%L	զG�Z�qI
r�Z�:
�����D*mI��z��<��
���l��Es¤ZJ	�g%��MK�9����|�\iC�(�
�S_Wּ���ċ��\�^aR��KݘbbiP1pB0���	���fp�D6������o�3><f��+Q4x˩��+���c	��(�b'b��cZ�C�pj�Z3�wC�wxr*=��%�S�'r����N�"�Êz�-�@�;����Z��!��Ƚ�i�g_�׏��8sZ���SȢ0�w�!}!�n5#�b�ϊ�H���1]���l�ٳ�}��\� Ѝdc���nw�E��2j�=�M��]m�O5*�`�B�w�!�-���Ɔɺ*�I�CJ�0[�hK�gm��yEE����qխ����:�����J����H«����	��B�8gr���+4M�+S�f�y����c���,��b�������Rn���E�<EG�%�����gL�h^몆�i>�=g
f����3Ih�*�$�!I*1�%�����ĉ �>�9��~�>���ZԃM?
��B��b=2#oP%�;X��9���W��3�i�K�B�k��/��м���A�^����k�S���1��>�mV�u���lg��ˆPn(3���P����8�tȷ�����[��)��W$�~���hL�x����!�ɘ���/e�	�#��El'2�DH���%zG{��ݶY�`l���1B�js�jtY~�	��ױ���A��#������M���0�r��B}H�R�Q-B0#�E8�L822 �y{sn �Y�^Cʑ�E���8q7�4�G3�-N�f�6z��Pd�uт�'��C:Ɖ�A��ݝ߿/��	P�6�N%��F��qՐI�B"�`1�� � ڢE	=?f�z-1�	�f���٠i��I�@��\/�+zk��G�T�k��,!�&D���ыI��!�4P3"4�]z�h��O��P�a�m����$���/my I4)�vi���D�@�C�6�J8��SZ�^?e�H=H���iOF���v8*ki����=�(�Z�-α���_���l}�Jg���R��֍�Ii��8��I+=y������8]�HQB=�'�z���H>��x	��U�$�F֮䫇��-�@eF���@���Y��DצB�j�m����=/���؛�E��AʛLg�)d�#��"p	�DQ�yAS�Q����{�1��95����Ls�����i#HK�ى7�*�u��%�{�#�I���������b����������L���BZh����
�Dܐ�K\-{�^�uTeF,~{!��0n�>ui�16��T���PX7+�t�WM*k�LD��F�>ծ5$�!	#����ǖ�U!�'����Aۊq��գ��'���{�arb�fDHF������C�U-��d������=V�,��uU�~��}����_&���C��~x*W��~y�gR	�:$���j@d�ԏ�?�/�Ë��=8���m��m"��'������V��L�8(�3���Ș��B�j��B�؉_���rr^��YPU0edv/��	��&C���$x�H�a�NF0��E�lJ��f{T���܊T����#Է�j�Mi�q&���!\���,F�o<��q�_H�b�fr00PH 7�l�E�J$ޗ��*������:]��!Mn�+E�l �1���ϖ��Ka�3q��eh����׿�mO$pG8�Qa���z�7���,k8!�S�i����,[ACؐ�`��Y�w���@�Xz������6�^S},��f�.�S�IgDfMT�{H���9~�/���i�yON�Ȩ=P,ce�3.5J�9-ep�Ǫ���L:C�lA0T���W���z�$�L<C��z��f�࿖��+�s	��e��5���
����/�Wi�ˮgy�+����(�Ǘ��ڡQ���OA~��Uf=̯�M���0	��{�����8�4@���ڽ�a��\"iP{/p�UW]�Y�c����Bs���$cj��6��+S3i��j���0��P�� h�:�_jX���BQ�-��n�Lp�媊�m�ţq'g�r�4���!��}M�������q�"��(s)����>L%C"d�blts��d��k��g�(� �!k u�кzW�$#e���qNg���+8WY_rm��fȔ���'���$��C���\�<�Dp�֞���}��ȏ��DɀIA�Gx�*�?fH�-�{��.��Ay����\���u�0��H�^�}�X>kڡ��^�G[쌩����"9!w[l�\o��5�Ρ[��5a���=�IRנ�E�b0Rw��݅�Ю���\AK|^��ۧ[/��&)����G����k&^�wX�x���ψ�    ʘP��3�m���)�2��Qt���f$�@'�ڷ�{K��$�F�>� $9��/��������1S�H��,�pFH�����7�X���L��u��+�<q�߉��J��4���5�:��&P0���&���Ȋ@Y#���W� �s��DԀj�B���@�IF���j�&냆k�hIq���W��M������u�C�:x+��0��G�"�V��Ds�z������,����~O��[����K�z�����<�_>xfޓD�P�!m:a��KvU5OW^��8F��%�.TO����g�?�uE{	aq�*ʻ���M2���H2=�P������8�c/Qw?mJO;q�Y��k��zE�cɢ��퇶<S��@)E�^�,=��I�r "I������|�{���a;0��:������C�?� �H�hQ����0��Hzxj	�L��ё>?]�}Qc_j��ַ�nK��E�'�������co$��KU���im��O�C*oj��$"u�uU[l��E��{�j@mo�7XM[� ����@_<ރ4�G��/h�p���4�{�3��R(?���oC����1�S�r��g=	�:���,m�����VIn��=j��[U2o�6j���i*��tB�p������
�ϡ����w�y�'//ʸ Ⓗƴ D���X=R��-Ĭ �(&3�H��^���AH|�"pwaԹl�4�T��4��d?1I��-J$c�pE��G㗟@�5���(݈�Z���m����M���"�^� �˴D5Pf��db`^S�Z57��[Զ�*ާm|���0�'�	�f��q ��31;�h�i�|AX��	���rOr)2Y�-��=�C{ �yPDC��]Th���Z���p�7��Cy�U���1%��$Pxt�7=<[�=��Ibv��Zt1 Q?y�5�oh�6��I_�ޘ/E�6O.����a*1Iv�$�~#�>Ӽ�2���qp��+�G��d���p�r�s�x�Q��An~�)��(�n��٢��+C�F�僸�G+�<4S)�Q��;�U�Lʑ�]+����k��g�Q"��[��3$H���wbzp'�͉�!S�S�Av0ҽ��<`!��PhE��=��*��t�<."�^~�P�����W�@��?�',�> $+|QH3a�EF
%/,f)��حւxF�����R�q����/I�����£����RŌ��מ�#��*"���+WH�B�<��)�DO�M��0��o/��H|6l|I=�#�4be�dv�ݣ���UP�I�zݳ��: /%9Fp�B�jFc?g�;�on*s�eB�j��!Փ�"~p��;oxe���m��Yeg�Z��5E��z�ug\�s��e)d��I�W
� �
��4�9߁J�m$�&}�:�~�ٝ ����HI}�%]�bc꿨���N�kTą���6)|��Sz�G��E}��jǅ��\{�ƓD���P(Q���T�Ab���-�A�EL2U0Ϡe��:хY�'��$�By���H��?+��O�~z���1Cb�"�?�İ]QZ�ӌ�!��^J�wL��r�KM3���ݣ�J���7'ئ��A�&@TOܒ�	�x��~ZW�ߘl��;�g���W��I׺#��ov�0�.e�.4'���9h��$+WP6�&c��<���^]޶J��P���UX=�g�^PpnKh�m8#b���l����ꡉJX�V��4$Ge�j������q-�BC\D��.m؊����N3Nǋ���������4#t  �g���
��$a҇����t�4eݪ�T����!�]��8���6߯P/-�$С	vb;�1$YIg�ʨ�P���~�cJ���m�\{����۵��s�s�qP�_�v1HW�R|Ƶ�%�ov(۫6��+3���'��%f�%N)~��^H�R�e�ʼ'�􀁭�H���o�v؅
�b>����uk�#0)m8�
V�lvD{�nitdin�$xȟI�)��S�u�2T`��X��ΐWޘkŮp��N�$w��4-�K۾���n������PvU���gm�ф��/�(�#@{m4�X��/Q�ߙ�!dt�rM�RG�Ϣ�
�L��$y2��2��B�]?2!z gZXx��O��+_�k",���OW{e褰���քIC����^�:tNY�	L��e��뜵ʒ��/W)~0�o�����k��+�%a�@���
���+�<��n���v��}�E@ �η���B��3:��
���L��!?Ӽ�Ϫ'�a*8�/A��+L�Ӄ?��~�du���3����`^zj:1��c6��T�Դ�Z���lcd��3���u� Q��z~\��Xߠ�U�9�"��O#EvU ��fy���(_)e%H�̈���
��eN$����Y�}�Y�r%�
�O�H�ΉX�$.4`���c8P�z�l7�{���$ix��b�������� o�'N!��N��X�{C9!����#ApE�;Fvh�j!�[UOs`�4��0�6�����oX��q�;;r�`��.�����2)累���o�=���k$z� �E�mLR7&H<) �iP���\~C�4���.'��y�7O��И�I哂B�/�HʛP)A��[�)%�U��`��'@(kΥ7՟�
Ne���i*��ս++c4�]��Xc)����֣�+ڤb���<��;Ů���`lD��Ki SI_�r�vw�]y�QAd>����;��'~:o�4N���nSH2����!N"��4����粸3O٤�h���H�]?8�z��+��D�b\7?�^B�~����6ճT�A����'Ic�v���qBI��'l��E�~{�Щ�:�? �Ec�P�ɇ��T�)��L D���\+�$�ӎNRBtk�7)Y \
"��8j�ꖀ"�&dHS͖
���<��������"3>��d�w�iNHHs�y�Q��"cPV@�j  ��G)�o:~"*C(����Ek3�"i�6u!81o;*8%l-�]��$)!*��R�l�!&�lw/���$�?�T����js�QMN���.R��߼g��>m]�'�g�P�y��+Y C�Y�0��"Uѫ�\k��+s)�J�#5���ݘ	4���D"�� Ă	/�{�ʽwM�2M�����
ȧVCbHj��+��G �V),���S���&E�&��F�KL.�xl�IA������B��ّ�(����(Nf=��1����7���d֎&�<�6�Gt�$l��4oE�ه�Y[:�ƒ-�n0��&�J��/E���=5I7��@�eO^�@�Uu�����^vX����m����������ჟ��m%'��e�p˂�w��S",sx�{�u��[?zR;��Q�؞	տ2��pث�)��-�����M���ƭ���r��t��!*�t�:��0��%I��F�5hf���WKM
O�@t�~��^�n��X.�=��-�!D�- �w�~��4�G������ h�U��h�Yb"�� ��Xr��&x]-�{���L��ՂKJcu�l��+�]�<�XS���Kc�Ҏ3~��8��W~k���sm����<�	��!<{�(��WJ�R�-Ada���3	9�&�Z���R��.~�����i&��T`-��AT^zw��"�_��:\G�֘O͛�� �֙���T�_��i=-�T���١3E�%<Dn�m�����P�>B2���y0��Q��C���VX
��m�FX���z5��raȪZԬ70J=P*Cb����w����F���Pz^�J��&Y�_|��Q���Esm����la�n!���N���w��9v���L��;��;?��9����:����mV�{CK|<?(A�{l^]J*iM�z[U��F�����̷��H��ߋ����kMʹX���\%TfN��Yy3�u��E����N���t��XB���� e��=]ǴX�Պ�ayEEF��*+��;��    k��\sg� �"��=�����N�ϡdl��Bud/y��ܵ/#K���ƛlk�}(s`åg�7-�;Dij�E{����a��!���)(I1W��?��7-Hj�Y)��#`���Eu��4�E�i+��8���\�#q�C�S��-|�SG�ܚJ� �
p�wY�^������w�+�o1A"��KJ]�Wy'�CN��w�S��@ekl}�²c�.غ*�5��|B�`�j�I��Ŕ���uy8�6���l���U�� ��E���
�y�r���sB0�����f��OJ����o�`Z�5t���
7����̚�cb���U*r�|�Y �Nv�p(��9-�%"ǁ�鹔��y'��UBئ�f�9�sR=-�W���P����Ee!��"E��� �#.�E�"�vmR6����d�r�v���X�*�ESܚ� �5o��k���5'cUͼ[��ޟ�~S��3��'�U�Z�_ɴ���&�b��^F���jZ^n޻d��UŬW���3X��1-�W4�UW A6����?���V�*Ǉ���^�I���>X���x�l:/~bZ:t ��͒���"D����v�-��1�k|����D_�ƻf
����'�@ߤ%2�R��9
��K���޶^�.=��4YB!��Rv�: kCt&�ka�>g��MC<%�h�xđx�=xLa�.L䯢��G����ӿ���pk��3�GO����p��|8��ס84�i�4dX��x�sS��x��p�P ��>wkWrg�tF��w�TfSʹ��(M�Y��C N��Ӏ$_W�_*�I2-���49�E,���'V�>z�LR3��!�.܏m����U^#=N>K�7���xr��0�FN�~�(�����"�D�����{���<D&1�h�$i��/X���k�J~g�e�xH�`"�II�D��
l�݋~��S�A׹���4��=H�L*�s�VO�?͢8	3)��J���X9V���'��I��p���
�.�E��Ws�����R�`�Cg���$\OWbt��}�b��Aү�@ONB�K��k�q��#W{4ϭ�_�2�Tv�|�Y[?w��?�)gB���v�m�5�HE
ˌ�U"I���߬�z�[b�4,rL����V��&�+S-.��~�(�/aq֢x��k24��J��bT/6��ܼ�jbE��;�@��4��� )2߈�]v���buw[}�^���W'@��@�0ۢG�l�%[���-&v�~��ݚ{�{�D�)	��m�z�~�GI��0X~B�|�T��͂�=��%Sc��}�|~�xl.�_ԫ�����+"�k� $���J�*��(�Cq����^�����d��Nr��G�3<�~�w��D^Ϊ6v����<<no��f���x��W�vpխ;LҼoZd�1���Tl߷LQ��;���d��z�<T���-ϵ0�����st�C�|�y�o��`V7$��zLt[�'�hX �H�)���.�;��.A���Bb�lokӁsVF���߲wQ���>3����vV8sPs(���@�O���o]%a#���_4rV�5�,��<�.�.�w���	��G㕁��K~Z�,٪e��a�TJ�ٌ�Ι\tιp=,>O�)Q4��ӕ�H�u$����p�	�w�'~5RJ���~�T���8K����۬�]��K{M�ڵI�P���P�לXx<�,,8(8a�¯�ӽ��P���Nǔ�(��ް�"Pf�:���+�W�#!�y�2G���ت�g�sQa>b�m^XbAj����a�ֲy2�ʊۏ�`���0C	�nQgê��Rϒ��;�8fuz�_�߼r }7�"�`K&���-��q��4�b�@��:���c}���A�4�Q�Q�K.E���������E9(���/0���'��Mg^2M��E٥a*a���^���$R.x�ڲy6����P&���Q@���7�Zϣ@��惻��QN��Kx�P�o����W���r�.�j���`�{�΂g��(B�v��y��0���~"'5�D�'8j�=�~j�-�aV�m��}����|X�q�u�ޢ`e��8���!��� ���`e(�" �_�çݚ9����tW�u�5�,���:Ok0Kj�� �.K����� �+h̞ 	�J�,~�N������K�3��xj�Qc�g���5��z����(��ea����1�r22ړ%�0����� ߓ2���MXW�󓗌7+�4����p=(f>]����Y3kSAza��@�km�t� |	ar��ʌ�r�5�s��ݒ�Y�����J�'gI��GL_^ f��W�e�/脚����S�^V7�� �B"B\�"kQ�O8u>���Pa���B�@u�G�1����������؜R��M���uT�����������6�.����0��;�G��Rv��C���
J2�R��.@��ަJ&(��0����C�,y"�W�����g�0K�p��P״��J5e+b�^��\�YR1�����V�g�7� o��(�ܫ:V��#X	k��7x?ynyrp�m�������&����*�S
�,�UÞ�Z��6C(�4\О�������gCآ�5�jV����:�bIJ8�rih�԰��x�Vд̤6���.םOU�b^�hRh��g�q�j1�b�k�N^�㐑�\e:j��Y9���H��Rd���.���Y2�U��%�B��|қʬ��.#l�v�s�J~�
#l�'@N���E\���R�m��6/ٺ�
���1`./����3s�g�w'����J]t٬L�|}%1M>��#��{�,]��F�\�����W/�\��Spg�1����t�.�dbHX�5��:zU�1�߽�ɠ�����A��� ,fqQf��qA�v���`K*�%X�~#͵W��_�~O�+�`��Rx�Ta�wG ړ�M��wջ��]bٿc|!�.�zJ����:��t�TYj�Y�2���+�b�_(��<5�P�� Vܭ�+��k�h�}2��E>
�x+8�^����Md���}�W�����BcAu��#��U�R�zA[3��~�я��ip�`j�.64��Y��VI��7��������L�5�u�6������}j��!EWh:=�HK+;��܏G��$�tSX���������*�U'��l2��[h���*�� %Z�uM@��/H~.��s���#Ͽ�Fʅ����j�����ʛ�7����ʻs�je�&���5��3����)�"5��cf��l���:��f��*��nde�`9�B���>E^ѾV�8Oz�t9������\l�Y�^�V@�	�ٸZ<����3|oe%Gc9 �!Eؘ�����N���EPdP�w�nF]�G���nl²�s?}�c ��&KLR�9[�j��=���Q=UJ��{�rº�2��xu^7Yhn�~�`h�s�l)z����HAZb���Vy_�0��9*�>��_ �/�,�H������<���~�ڇڛ��cԞ��l?�1hfʮ�̼`l�/�@A"R
�G����y�6�T�S�7g0���7L����%$�:*"2�6A�,��<9*sC�*� Vm#7���C9��^!xh���n�j�{�X-�x̟ޮ�I�<-58�C?�z�̿�,�{�B|�\�zC��^�XHg����<yù��%���G�U}CnM��I�P82'��Сy�P��"{^Qq�[��Η]�ܟ�J��ژs�)W��S���b�f<������4�:D�S{m� @1�֞$�a~��UbE1��d�bC_��5
����h���%���<y^6�� C�e��mm�����7%N'�+aB��:o�&]�F�"=��������1���~���S&��y���s�Qϓ��
��D��S�= �{�qr6�`I,�*�_<�O����Z	Rڹ��a��0%i��n��C�l١>�F5x�۱lDd�<�j�w�Y��/q��$J+3E�+�38k1[�j��:�D�M�L��}�������,��^��FL^z��    ���!�x��y����8�C���t�4����p5�#�KnH
Xx?Z���r$H��D��tI`��|l��a% r�����i�[�� P��2�S���y�ԍms(/^�����.�;�UC�u�B�����;d����3Zӊ��HZĻ�61LY�5�5�;��3A�����v����/_��l�b~�v��z���~�+�AB5c����f!5���/K%0O
|�C�;T#�?7�d��N��s3�]6�3$!���q��߬ۍ��\N�m8�X��B�˾{�'�G�D9��L6�X�6�-��C��O-��<���a��Ca1���E��V��v����T�w�^��Y�hxm��p�*��to�����d7JÍbN����ߞ5�<��C��
��S���+���!���V4J w�J��0E����r@�2�Q� ԺZ<�6SR����3�X���,Z�8	CQ��k�p���2���ZcWi��G��+Ľ7�?.�A9�����{6��dp�&}B+�&Ɍo�/��ؼ�;��������޵��� �Kn��y��hßj��խ�i�s�h�]��I]0�H��ʷ��!�L�0��� 䢽�M/Y}�q��I��3�y߼,���H���$r� c4}gL1m�c�E�Y�$�c��\��@G݂*�jQ�L�y�:h��?ɱ���w�pLJ�jx`y&Ǡ}�,�[� bH�3T�;����A��z$��p����ů�/�����C�3�\uc�m� ��V-�4 ���hT��0�O9KziNx"N-<Z�?�'����ԍ	����"F2�hփ?<!#�rYIT��M$�1��U�95�ؠP�L~_�aE+c�^%mCƣ��=y�x�s߂�A�}�o*�+�F��^7+o$k�HY��T�[1���g_cBm��I�|�>п�;!�Cº��4@U1��i�F���i�9�
+�=]s�]��zc�\�	��ZQ��W��@p�8NEҿﮯ�?>,�ը,9 N)Ui��,���;�'������[�01y�̺xl_
FJ�
��h�;ǥ�g���cK�7ҵ�e��Y�3��Z��>�g:�b��Psx\��9�5+k�e�C�����xjZ?�͒����|���'������fH���[�8츦�%c�pȟ|@hgu?a��s_�@r��>�J�E���ކ�N�1-�k� S$�ss�5�C�!�z*��v���;����b�X������&F��ÿt���sso�hL֠�j�$��ꭰs`���,��hj�/U���ʈڗ�:���t�Y���V�9���H�B��]zsX�=�w����q0�f�Y�����L��
�?8}�d<��_L��4�9dD�����|1�q��ؼs�P��67D�9= ��o0��(W�ƨ����Ʊ���1�{*8����^�fP����$^'�&Ң��Dr�]4鞡f[���G1��&ČWV���M�cN�:�FE� �'�溵jB�\�2*L`�j���mQ[��8���L��m�;��e����j-�$g�43�wG�#Q�r�����x�$f��V,p��c���=���ͻL�A-�2>���	��fu�T�N��_� 9A�f\�}۲:��<!J���c��wB?tHO���� ��~f�����=Ƈ�����M����fAW��܊��y�9ߒ�Zu�T��0͕w�$?C6]�F&�2�,��H���hK�*,�(�f���XI͘���w�=Ŝ��{c	�y��T@9��b9��no�.uzwY��2'�T�9�^F}N��S���w��V�/�'��)���	C��-�.OL[A�K���N�@?�|5��ah������e�oOi'�$c��+ů�������v�"KP����A0��ďtx�y��`�N�y���yj�T�Xy��h��x�f2`}�"��|╝����U���{$B����5.E҅9��zog'��G�$�5e�tx���{�1fl$/��_�=�m���y_�?�VP�����[@�;O�̃��B�|�V�<�k<��A�j6�����ĵ�L�[�nr2������y&$CYrǚ����})�=���gl��&P���ۄR�y����s����c��h������hDb�n9s�
hwa'��� ;����y��"Wc�(�J Iq�G�q�q_`h��Z��$����4�Rn�=�ϫjy��^���[��1�ǻͲqB�Y�iOF2ے���C�S��������ƐP&~4H����܀��B����?��s�tDi��|7��:���	w���v;�禗<4��|�U���Ԏ���~���E��-v�,Ϸw��dkW��(r;�˓�s:������-h�nH���
�����c�)�`�c����n}G�6^Uxo�CBGf��g?��'f��V�R���0���N%A��SMiiUyj)��(4���#��jk9�(��k�]�
�2��"��"S���+o�P�����I������o�%ep=�����G3H���?��Q��L� 5�W�7�$��{�XS���fR����HM>�>�����U�����&gc(O��E7�8ʲ��~c�'x�"�\�1m�"C�1l����]dGJ*�>*�	
sj�q�!`p[�-G�����2}A@O���r��""���Gs�����$��^�5��u>$�#,���y��Z�ߞ� �&�ا��� �ۃܓ͡���2�Ğ�^��<.������3�h�^�ϟ+�H2�>�ɉ�iA��FKO=�� ���ce�(�#y����谻��m���o�	����!˜/�G�/<8 �:�e XDk�[b�U2��?�b�ϩ��%�K�mv^�� �!&�������IC����$��^<����ମ,�>�]d*{��tg�r�.Aqou��!5P�/��ǭj�U֓4%��b��<$�V�b�?�y�̏!�.�5�8`Ԉ�[�VO!��^��f��B ��������CJ'�:Xs�ɜU}mZ�����2Ԥ
b�9V��B�G&A�pˣڶ�����*h��^
 ��S��g�󲹿�^����ܧ��P�Ld2�Ƥ'�:��<c���D��r:,�n}���Cw�j*%C�qp^�x0��{>)H�
Ym)���i1(췀Z@oi��LΚ5c�A��0���u�&�C�=��ʼ�/�gK_�o�~7q��b�V�Α�����T��>G�OTvKo4/+������8�෕�<�����G���9�	�80!J�����٣�$�v�&�m�� �6���u��x՜#0�#��p7��~��&�Q s1_���2h��E���k�?�|�����Ss]#f��gG�'��j����bw�_}�ћ�&���'ޛ�msz�����sW���v�ᚌT��BO�E�P{IO	���n����#����v���s0(�K���u��hI�\ԣ"bE��|P�����I����"b���O��٘�2uk$���NU��t\ǌp��kOI�oì�P��`7+%��z��E���Y��o,ԗ��:�W.�%|�k ��.�"LF��D�Y��%4�\��:=ձ4��aJ����1���7#�cXV2��2ϑ��r�Eǹ/�NqӔ3-��������M}Ap[��/��'�scd,*KJ���1���H���GI��
�)T����O$dX� Y#\Y�O�X(>���7��o t��^=�8�����Ø�T>����իKm2L�9!��4��.M�纤�%d��E����y_��lܩSU��3� �i�/��}c��12K�6:!l�Co���r��-���C�E��n�±[��Y�jYj�I' ��`�̡�d��$l���ǿz��d��⑖��A�@�`�[�s����.�K�N��֐�(Y$�*�5������W�ƒ��	�)���H�)ʙuwg�6�DA����D�q����Cw.?9}�1+�}�������P��W�����=�#��Lw7���]߶�]����;�x^b�]�.k)��*�<    ��p��}x,����9���"�E����(u�	ga:��s�������jbqa�H
R�~݇Ek���!���b_�t��c��<T5Ϟ�4���,ݯ�C��D�^���p�dW
��q,5��t�bq"P'ܭF�!��{&9D� �)�4�ߚ;s�&�xG��h	)�[�Vs�MjV1$�9���PO�w������
�V�)WU��,X
JȄIOHK�W@�
�]-����y�K����ȺQ�/L:��-�!\^�-a���i𚜃��Mr�)�1�+�Uz%���V�%�[	�� ��C��1��/�?vX3N�>�.���Z9/�{���!�!2��u����/����c��򖖎M):A]�ea�y{��d!���0�;e�qA��y�%-D!R�x�a�����u�&'d'0� ���h6GI
�"�ϠI��s~&R����z䤅����腏����ʓ�%9����F��8J�{ӡ���P��.�X3(ā��3i!'�Ius���=�P-2Y�5��>)�@r\�~0��"�E1�k��P���hN����!U�:y.�����ꦭ�`�֣���50Ն�6c��E�^#[xz �'�P��V��0����hGJ|��PT0�f�[������B_$r�l�=�k!��ǒ�+��_��($��V�yyq� qF;o�,���KXr�7(P�0x—>R��[&��ڤHi�^x�05(����ϐ��<�Qz|�u%Y��1ٶ��M��QrA�qp�D�7�$�k�d�4�r��A�{V�#��3 7��1T�ى�-z4�8���{9g-�h-�#��PL9£�1�؈���E�6�Қ�L�R��p:
���L���9}�!��|������#Ӧ�Հe�\�EO�V�f���p����X`���vN����~�D��P����W��S�
I�����M1[������������K�%�#_ת������DI� _S>����A"���7S&��p_2WY�>��w|�~Z���m&#<Js|�W�p�yM���۟a��׳������!�yB�Bܒ�*�v.��$>�Ǒ�$���_*p�����F�3yz	F�X�5�]�Ҭl��\�n8�2MZ* H������UC/젂�����^���̓w�$�c�p&�h�4ğ'z��p������,�0��D�T-x�}]?n���R�+j��"ݣ�\�G����Ғra��%�f��Q$�>a���RՀ��_%�EuO����R�߱j;�{á��Nt����7mwm~�~�t����EL����T�ݝ�����yTl	���ɀ��`��R�����!�Uw[���w�F���?ʴل��%�)��]{),��>̹��>�5pFe�����_GV�M-d�=yM�8��{Q����*�5I�3�p8]����s��*U�_*H�|U�C�ga������LiG��|n�����!|J�f/v�&�W(����%�k������Љ��
�^�`Y��FɠJ/��=��}�����!�_����k$��;e�ʡ�I ���gC4}�\B([R�Xo]�:�Q_��|��y=�,�������$��o����2ԫ����qH� �����8+k����%��h-�+J��ϐj{ES����J|װ�_�փ_�[�EOV�f/T�[O�OJ����q�.bjǍ���G`|o�%��h�;�G�'���jp����{n9�ƈs]�\)�/����D�NI� �wW��!�$>Q�ͺ�[(oRH�;&m�f��=� ��]v�Wt�����C#���UQ�����b|�O�k(�;2�����t�@͐DW�)�LL���Y�ݜ	X��<�M�z�+������k�-,n������=���z�h���鴄\qFB��נK�*+���D��=��nȝ��PF��/��!/��P�<H����N��o�S�W�y{��| ]��Ү�kՍyr�G\X8�۔��R��W�y�".�,I9X�l�(�v���.}E�����i2�QA�2�����W����I�P�=��@���_-�~� 3tˬ��I�E�!�����O�x��C!f�[a*�����(�B8�ISG����7Dt�cT��ȊE�z�e��Q�͢6�T���!R�������H���֣���BX� ��b��IQN)���zCt̽�LP�m��r�Q�:nKo�%DӮ	�Y���k��U�p�$�F���EF���PJ��G¦��;5�:%O�:Փ"�x�j������^�����e�,��Qol���5��GE�#_�F�g��05,M�}'{��\��R�*.�t=�����B�A��ǂ�dc�8���ۯ:�o��#p��H@q^YJ��t����qO�0Jz��V*�d�2�5�+��� !^�����h ��4�:��
F������.
�=�E0��l��U�$;{�/l�t탪�F\��'&,��_-wƢQ�vw�>gT�*s��ү0}QhxÚ�?ʉ6��8��G�b%I���!��PQ��b��ڭ>wL�Qe���e�ZS���~��dC3#���G�r����lg!�ո�a���Б�n2�����@�2(:8�����"V$տ����Vw����z1{���4V�r�����?��(�!`Z�3����˵΀���PȀ�)���?�dk�N�$�(mvL;M�FՈm�V�����I�iQ��`�Z��ݍ�n3Nv�8c�jp��:G�r��/��%6Nz��
�)5�YШ�zv?C����	I<'�V�,[l�<�{���b�+B�\*�m�*�~���u�!M����Y�_��b�3����Ao�Yq��*�����M`���MJ���)[<ս�P�n����&O�fa]�V��	c��P�����튼d
'"Q}�?�U�k�E��,D�R�@��O&#�([Nt�H�pc2e��	�3�xJ��k��@�V6��������3��͋�~u�xw�B^�$j����M�h8)��e���w���9.��(!u���[{��L]��pU�3!�hM���WB�Ѹc�.S���p!�w-���́��РE��\��:b\$�p/K�����ȽQ�Z?ZT����S���L��8D$��J�R)�~�f��m,/7�o�fb�h��ů y�aO�}��;aa�D�=k��{O��"��Lv��?n�d{��<j'0��[���6��ٔ��i���i��?�Ȋ��wW<����%�1_�0�b,���p�oֵɭ�|�Rr}�d�y���eQ6N�����:(��in��O^|,�Ң�&ry)�(���wW�\�6`�!�}Pҭ�V�+�kWf���� "D�;{�
����Qb|>�.1���~���_}�k�B�]��{�Ｏ��ᶕ��OX�6�յ3��Wțx�=�E-[��e��2DG�\?.�g" ����nAA�GB����$�ҳ��H�(�@r/*A����|۰��d�9�G8/Bx�3}^#*��;#+�I�@U�@E^� �Wu�\�������ۄ�"QJ2�3�H)+oI'��=<�c\}gN��E�|� ��w,"{S-��Zk�-����2?�p�� 7��֦.Af��P6R3�#��Emg9��de�7�*�~������4B���F3,���������%c��Qƴ #1rET���Y�%m����D���j�v
��	'Q�[Ir�N��a\f�hٳP������#�����O��+d���Y�Ԙ�4�!�&r!`�!��^���!�aDF��@��[�]U��h��M����mk��1n*A�#o�^��[z��K�E��,i��>1�]Z��k}܂%D`+�?Mo�Y={�UiB�,��=Kߠ8�A=��8�"L�U�2�َ��C$Ҍ0P�Ӟ�H��	N�r��w��*�!؂��!S�l�7�y�jO�u���ҕr	�K]v��<A��=��iΘ�EXǄ��;
,� G 3�ɧ�(�;̢���G����    ���4���x
8�s=�hX��dŗ��M=��8�h1y��BJJ�v���kR?4xA�(�%����v���H���S�k���x��q��a�
u!J1���ϒ���Md��ױ��y�=?�����A����6�A�9���ϕ��r���2Y׭	+�J�e!�,�B�%�\��A{ D�+ ���G���o�k��)0Hl�.�"FQu���qҿ?U���߲����!/k���u%[�,���
0����;�LzG�W��������S�	�V
(��d�x�˻I�Ѡ������ɟ����AE�Q�u&P~p���f��Ź���	<�/���RH2@�/*�/�B/^�S�8P��b��2��{��ٶ�'�CRV8�#��	4T[}񀲤q(f>F��#b�S
�O��S$��Y�`������K])��k�~��P���F��u`a~�~wq��FX�Me�lީ���Kа���b�,���qA�\�S�©})B��v�����@�!B���ݗ���5GH���5�e(�9Dl��й�>��g��8�&k���kF�8�2ރZ�� u�-��<�t��E%\�xW�q�:H{@��.�%.�s����g�n�5����ݕ/V�@��}r�uq�
*�c����,2H�s��|��7%!��]/Zv�r_m�2E�bi�Δ�`ft'�C��85�?FC�72	�cLa��w��������\�G3� # 7�pT]���;4�7I�8�J�A��%j�Y�4aR����	�W��vFh���]{n�����XM,?\dq����]2�z���!.ݱ(.�h祚�4ZR��liv�-&W�_�y��q28�⽉��v2�x�n����fx�vw���5�r!�U��y���	R������?��$*���ј���R�`�o��dv����LX]I��P����%`(i?&�lA$��8��*�T+8��aN��vI����P�Rl (f v?� ̽���2(�7h����v��)��^֯ٝH�P��Ś��Gӽ�}��$M�4RM�� Jo�&���n�u����R�~䤴�Z;xon�Ci��h��K�<Nlg�䈉r��|�t����|�9e$�]ůq�c�nm�"�E�	U�tOo��e�S��K����#(X�C獨����;B��_c���+������~ʢ�(��R�A�s&P�\������CҬ���q�:ڶR����� �Zk I�t;�n�Oh���Yh��z1�eq�U�
g�8%k�x����HdmQ)��W�g�l��e{���o+��@5���OSD��M
9u��xx�q9`�)�9���-q��u{cM�1�)��s��.���h0kq%�)�4�m`W�,�3�l�o��s��n��gݽ򂼷M�4� SKy�����=�����L�א��F�<A��^6[21�$ E�T�,y��B�8�­w��Z��kPY���Ɯ�"?�1mY���e�N�A�/_�_]�4��B~ ��J���Ӻ}�3kMN�=��Z���p/�|�(�UX�l--*��P��9J	�,+�Ū�Za��ճ�Bg����ů`V�V� ���/.x��@a���{�T_���N���&�[V6�6H��k�qV��7�R1ǔ�g�M�={���	����� dvOY�x�v�7h�5\�l�#>~��"�R����M�΄�zu�E�Qv��J��~v/���2`Y�OlN�WM��b7H9�ó���}#&yCQB�L'<�����<A�FPmG׻����n�z�b�7��c�,��	s��ʎ�cZ ��O*��Ҭ��CN䆗|�����x�P����|�,�dѫ{pjA��E���q��	����
�/��'P�����Q����p	t�� ��O�[���j� _�3�G���Z���tQ/�]����ת�L��q29(�Xd��Vg��ou��V�Y	�S��E��?'��x�Б��n\�g�n�:!�ha�c�����mj�8�Y����z����`�q?�X<���3�����*�\�k���8�����l<�B�b�p(�ANDR4�����r'aJ�t��	��k3��8iZI��L�XI�%%�C��c�yڦ�
&]T�7o}&�WL�R@�#����h}_?�%wa�A�����)�w$z&�#������n]�${�B׃������	�o��)鶾���k�0p�T��1|�,�� 'd;�M�l�ʅg�P�C*\-6�2��C�`zЁ��O����O@.����uѰU_a�$n�}���P����|��\hM��t��KD�<�K���Я:g̯���'��ZfI�R̈́=��cbP��QӏӳC<�C�=�����5�>�����I�A��P�Nt�\T_�Ы�"�EI�{����aދ�c�h@��h���R%�(ZtϜno�k 9�O����������׃J�Y߬_�$�2dVV�����w�{��W=�`Ɂ��K:�I�u�\T�a{�D�h��a�E��IN.3s���A���� �~��]v�r^`5»{�ڔWt�-G��@z����gOqR9$��@iF���(Z���Ŧ(#g*�Pc�vO��E�U���&�4�B�y�l2�]_{�,�[b�QB�q \��{���p�#n�?�0���.%�E眪�MkB�'I�@@6U�>f���Ycm�����M�������G*����b�!�ĳ�)�1YQ��Q������`�0Ij�DM�6�l�$~�[�HU�
��17��?^�;K�v�l�!M�,�ѐ@K��G�|��H!M�_�S9"?���Ր���k���*�[��V ���.�5:UJ͞�����R"������@��ڍ�����Oa�a�ʿ�E�b�h�r��Z�1� �%��"�Nc���J��W�s�0�jzx;�������P)��(�;x�J��3JD����-�kȣ��W߬�^v+}����/ҍ
����A輷�Ӣ�V',�C�[��d�gh4��C��qFp����&�`�r�Q�3���l�ݤ�.�M�=J�/Yv��$kv���p�|\���!+��ւ�A�����������5�!N����{�9+|@2BMcL��I�!�M�� �Q_���gFdI���@G鲶$��Zx�|�����]��'�N@��fW�L��D�a�9Z�މU5"-��EA�"��N���!�,�!�� \V�{`C�*K��P�	��F�d0@uxyL����mc.9�ˡ���N}о��-�E�CxOd��+�e�y�u����_j�W��0�5��T��\�|T��Mc�uᐪ,����7�L�	2_6[.�̐�r!�45_���>A���:�V�(�歝$i�%�u�کjΛk3�S��
;m�c��=�����$e�����PRTq���/�|Yt(Y�-���C�,�5�>n�5���+s��O��%�sN�0k_��8_��%i�fq,�Egw����GM�2s��
6E�ы������x�b�o�Q�\����#C�M��o�oG�0��B�|�͈[-�+A0_Ģx�bP{ �rJ��;��c�~�e�o
 O�Y�
�GL���K ��ًx:If�PX�@6ʀ�H�eL¬���
f��Cyn1�O�?�);����Ֆ�+r���1(�r9j�c;Y��#�?5a��m�dig����8s_�Kx���z�l�H,���D�T���b�� �B�g����:�k�U�J�c��$jL�=��aG'�����f'�x:����w4��>h�%\�m@V�
�*�i����{f2�ŋV�M�%>ԟ&n��ĥ� )�tC�?�tz>t'�Π��U�:�&�=d�kHP^'_zm�Bp,jḵ6�5�I�Ϡ����E.�zu߬��y?U	r�(�`�G%wv�6�I��B��סRԘO^Qfa���di�� Oˈ]F��H�3`Y�+l��v�%�Q��H�+��l�)�Z�����v)�e�[S��9C��Qۓ���O�ó�rԥ�E	�A���(i�2W�o���$    {C)ht�Tˊ7b�I>��vI��ڙL J�+R�)|o���Gzn9R��� �ٻ
g�#N�y�p�C�����Ko��d�و����@g�!��ܸ�W�6����N3������neyK�S�fh�I��"4j�F��G�5?u����,�1e �h(;N�&���b�"^�H�tg����sR05X�lX-Y>i8�?z�m�q��=,B����ཙ[��߾��:���w,dr���Ë�o3^j(�B�at�MrI�Z��OC%Hv?����2 è���.�f���	��J����yg�Y�*�zـ䙠R�J4"rk�Y��n�L �S�Cu�l�Yy�����M�+Ŋď���gxK�wHw 5�-b��ً��=)�7�х�"�l6݅[z+K�����jd%���*J�%8�fS[�8�=��c@�>���7�a�ѐ��E�"��S����㩚����t��+z��#ū*��;�T�n_�um!t�b�������}�����2$��?�M��3ؼ`_x+[%�$]8T D��Bo����	�CF7[^�>�[ ��M��4N��A�Ha�y�v�&i����m�#4ܜ� �&|@
����PbjEb�z@v��W�O��S�hgfK&n��)�|������;w�8LF�p*�$ ?�8�
y�D�9�_�I4�`�5���F��_�WM"�?�n�)ޢRm�s��������b�;2���4�A:ޣ��R	��n�x�l���u�8�$r�Mh;(�Ok���f�=ou��ʄ�VU�~��n}Oz$��5���U<��a�Lp�<���5fY�d�����]�;<:��$����F?U����¿�cR3���(L��Ia�A�Ul�����g]�����Q�:(A���^��w�HO(=I�����W���ś:N
Z� ��8�X�~ԛ'�d���v^R;��X�-��@�P;�g�yN~�� � j�F����G`ty��f5���y96�I��"bE�]�-�sd��O�}���w�B-�H���x>�xWy.2�wA@�?�0)�9&�:W��c�u�l�''!�P�"s����IA�����u#^"�'3!_�`�@E��w������
��P��\��\�� 
Zz(�$�&]�ڝ7�����$Ŗ�A�2��J����$��15>CG-������w�y�N�>����W����pß�h���:����FrT���B:�: �,�U�y�TY��`k]��KOm-Q�5� L��}�$��Z)�4��&݃xU��1ӭ|	�m�Ԙ�a*�֏�E�֊⚲�N�m�������][v�j��N�٢Y�{a6���Op#�p+�h�(�,��{��U��"���;o^����-M�4���J����L�<�� �.�+�	���e��8�������C<�'{i��J��[�t���ŀ�x>F"���D�-��R=�`\��k!
S��d7K��cWߺU~2?\�L����s��;��0I�nB�`ѩ�s���b��d}��3%�o��韼g~ǮG��L\~�o��n�{�-�B.l�La��e{���{�&��>�3�?w�N���I��
�J�kb�[�p��V7^��| @���Y��w�{Lt�u�a�E�
3c�t�:U�^}��E����2�Aш3��$���ݏ.�*fa�R�1�����kv��̉F��mC�j�_'����ėzQ����W��5?k���Jb,�9*�=z��dY��\(�g$��#/Hӈc�DD�F�Z[� �0K�]D"sUT��&�-�%�"46���'�>I����K�A��r���Y�'�C��mn�F�W�Lkʎ���W��B�VK^5\=E)��	[L�O\݃7f��,��F1$�md�>���0k���N+hLO��"��`�౧m�a�n�<)l�XX��Ǽ��^���!s]2=��NK�s��n�����n�T�_*��-#
��ū�Qj�!vL�C�[H\o��� ��a�=��j<In�4���@�p��y�$w�p] ]��M�A�Bo�z���`�c��:���}�q�>j&��D{�5w�e�y氤�\��8\��F�_^�����=D/ݖ�إ���2nE��*碑��f e�E#���MKե�_X5hݽ�;��hq�?5��_꿚�g��1M��$��r1m9o6�C��as?\U�Ӈλp�	��CM�3�8!���0:�W����ǭ.+v>;Dن{�^2��}C�P�˺��>=5����eAK4�QI�d
���Ĵ`{�<&+Xwř�zS=���ϛ#i��G��޶:J��|*䝳��H|���f�T���ʈ�u�a�,.6(7�/̓b��/��{��Y,[�y���3���,�rh��[��-E���~�!��D3g^�n�)�����NW9<����j��a�<�Δ�$��䨈/��L���MY�;#%Ηs�;��xZF��ME�^�kك�կ�#�(�� ��D�,i�8y?~r��39V-GE#@���0C����J%�-�?кC#�~����V�1-<; 6O$�nI�:Jx{5y���c(9��깻���
�2M�����/�M��VI�
ktp�Ѓ�M7S�Z4�<EQ���
���.�Sj�#�+���)��[?y�#�P�q��1SWZ���g�|E�7�7�t2ԉ�_0�9f�.z��7!��#�:b�4L�Gv�T聦����O�S�u�M���П��jC���W��r|��9_� =�����AY���^�@��[�NHJ��ag�����8��z���?ww�}W��
�r_D�����k�Ck�am�rte�q���4kբ7�w������W��o�=��i���9k��,����1�n��.�1��^y�f�����#�>/ 
���i�5di�(w&���'��0<<�jZP<�p�H�?�f��dN�Ճ���8�]���״m+N�/L(���rP�c�0��WiȲ�o'uU(�tI�4��Տw2T=��1�~j,�!+��U*������mHv*3�꛷���7t?<6P��O�<��'�b�o��'G�����i��f����D]on9�͟*�TS��B,>տxW�HeU��C��<L���}�6Ko�[�>��p����y4)_�"����(.Z �@�ڕ�Ƣд�Y�9�� `�=�;���������I��1\N`��Qt�(�0��&Hr�ٿ7�S
"Ae*��#�¢�M�j$%�Բ,դG�/�xL���}�U�P��G��k�cd�{߷��h�%���z��P5-H�n���� �3����GY�2`k��ryHx�b�(�]$^y��D�����������y���dǚĬEY?RA��J'�&��P���ũO����)<�8�t4�ȏ�@���K���Հ7��7D�0 _�}�}�"�En/�դ#uD�[��n=m�4�>�Oc�F�p��ݷ-�XU��`ga��P�CE�B�||F��E��P�`�y"��l��	�~Аp0\�(���T1��d��Z+b�dJ@�`�[.$��m��*�Y�e�o�t���[�p����ލ�4颅:"���6ѱ$��Mū�*?Q�*aYP��-VX}h&GN+��G������r��:��Q�����l�捐^C�+ ��6��P(n_U4:k��se�l02<���װ�1)���}�4c�)F�*����8c(J�����D*8�G��sӤ�⚰�tC�@x��*�������T�0jqݾ���pb0O��"�%��9}�_D�٥s�@�YR��h���ԏ!`D�m�C�l#��kM2 L$�3Y1x8�,n�+��p�wH�m����DA� ��k�3;Z����9�,އ��P��a4J,�z��r�ҭ-�B+{x-�b��T��m��I�����<R|	�~ݽ��~��B9+��(��(��;'�놇��E������_��_�1aÔG@>�znJo��Q�ĲF�zDu��5f^n ]A�!���FV2��N�:�MG�\C5v��^    7ᓍAs�}�D< � �k5���o�3���$�P�S��;�+��! �f%�ߝ5g�x;�$����3�U�ᄎ�X�`'���,�Գ���@��Pll��邁��yM�=�R!W7[Zc���A�~s㈶�����ZG�`��B��.vڟ�AM]���b�hA�	��t��U8���A�ȗa9Jw���h��C���e'>�<|h��}g��m���j�y9ѳ"�P��PL�dB�#��V�6K��[���!n?����Bl���Mh��>{��Z�!��o���YA�`��q�S�K�c����$�ϒ�1A�RY#0�x��/�C�rq�,�#ZS�'L��?��z����ڹfIQn�br{���{f��qA��*�p��8��K"�<Dr�=���	� �P�m�Ss��Ҫ�g!��Ψ��!���f ����iVE���[�Pp�ݶ|V0AvQ���$ �ٴ_�7-R[�L����0Mt���s��ɞf��+BXD���0/�w�/0j�1���F3z���6.�V:K�=Tvay� �&h� ��Z�S�Y�41n���W^LǬ�j9:�cZv�8EF�ϲ���M>dt�n���.c8fՉ	�E�v�R�a�ߒj���%�2l�hs4���.-f	Բ�k�|H'�?�E#�+*pk�&��S�梂�~Q@��ȢL�����l$��?����z��*ۊn�C7~$��Ç	�:1y,,NZ�c��Y����Ǌ�#y�Lӳ�8�Q؅�~΅�u�~[?<�s�9K���������F6+"��O�Ta�Y���y?���Y�<�?*p�CuOt�²�%�C�T�EƁ�1<���v�ۡ�q������1b�\5{�6@���D�D�#���#���k��E��}�!�ZE��O��������zs�e^cf[�q�J�ӾP�2�%�M=��,)�`�෿�Ԧ}v��6�ʃ{A$\�]��x����[f���0`�J@��]�\�X���#2���p��$s��<��lugJ8��L���Rg���"���U/��/�T5rU���_�a��&����>7.l��ּ}��k�BǠ���œE��.=)Ed2uOa^=��r!d=�2=�m�A���:��ӡT�p2P$3g�Y'����*49� �d�{i� pO���MmI��e�X�FB��Cw�Buoz�ϒ�`��ʢ���R�_��ի�ݡ��B&��?�z�yx#(͡����P�`�j�#I� ��̇��ԓ���/�'4����W�u�􆓀z�ȍk�M�!ײ����k���7�D`VF��cɐ��X�0B�x�,�=�D:�������l�����Dݹ��e�e���d��P��`��,�o�)����AQ7�P@I�#����k_�� ������q�"̅�9��o��O��v�-��u9��2tհ�����qY��w;�'��`�UG1�X!��>m���$� :��W$��y�@��H{7Y3��M|����1�?�=��n+�̴tę�+j+�26+R[ ���iX�DT�7� Ly�Nj\he���������C��(�C�G�j;B�/K�W��`wy�5�S�҃�hJ:� U�ȼ2����sP�@T�	�.��G�%��>����eO�A
`�7+h�r�j��%�����?��r�a��Ӛ[��4+<�R]:��EY���\Q��P\�h0b�p��E��w�)-�5�G����ˆ�#:ﳖa�1���@��9R*	lO������^��
_����`��X���n���GR�}�"����8>�v?���	�������S�zF��Tt{�J`��Ub]��(�D�b��2�^���Mu��)�?�TT��E�l�����KR7�((�<i�I�P����ּ+ �"sѸk�J Ϣ{ݠ��%���Pޘ )!{#��aS��%w�>H�	\,���~�^��΁$p�cp�*r~ f�p����I�PX,��� \ݯ_�����.���D��y&.��d%���dD3,�n��l�12��|Ie��?S��C�A*��xH��:��֝;[|6Uv��f�??�B��y�v�s:b���lȮ[�I4Ҵ [��j����m'������%ij~��*T��tk��dl�tLh"���흽���bJ� ܂��Mu��M@��}Ԥn��Ɏ�U�s{&YCQD���E��3�Z5��=��W�\�P���q-�?G��dR���u����y��/Z����*��]g�O�UG��U�ӯ���O��o9�����!�J, $����W��^�<�S�yR��1n%f֤*���7���#e����������;p�����\#�����K��K�="8�
ܺ�����Q�U�"D�?���U$�V�+נv^v��"2��j�����������>s�Y1Ai�M|X `glϮ������ziQ���` �5�g�S���"�e΁ �<8�A���Z{�y���ǜ�.��AU�`�����h�l�y|�V�E�����X�!��·������ֻ�1��<<�fKP�i��Z4�yaȁ��P��h�#��7���#����>�y,�5�����"4�@K����LJ7/ޫ&1�u$�&�3������*iR�t�1H^�P#���]޿�3ܔ�y�q�uG�*'t�V�������6�N�s��6����QΠ�Z���_W�`����p�ઍ	gD��I�WMfƉ���2�Rm񮳜uH �O�]&W���(!�f���Lcd1�t:k�T�쀝����$���u����dPg�Qlh
���F>gNG��8�:Ģ�U��]-Ѳ7�U�T?��S�V�#=�/�1f�Y�o
���-��?��J��J2��XsB(��g ��zOM:6�;:�D�@��,�Ľ�}Z����BIw�.;zGk22�|�0ِ��F��v@�٭�r���"<A�����ME¦����Un�{u�L2|jna*Ճ��.�k/'Cc���loHҰ ߬�z%h��%I��2քT����U�{�vRkz�"��D��"3�(��N���ќ�ϓ�q�brʖS��ߪ�n�3��dj�D�|!�2L;���n������֠�$�q�v�c=M�<�� 8&��H``�{gDr5���_���${ad�$jp憓Ðk���5V6=�08�/a}KݘԎ���3��ʊ��Ub�{�$�A�{��(�2�-f�<	"U�m���@���e
��N���M��|��w���T#Mt�����=�P�;"��3f�O�����w���U��1���(�DN'ۜ?`�UGg��ԫz��*JU�W$�N���������z��{�	_1L��*�1����q(IZSFB9;��)�%��@躻:���D�5��Z��KU�O�G�ةBU�3v��'�!�b�W�L��y�栎8��p�]q(E��'��S�DL�Q ���@�"H����dr�!��3���)����޸p� �K�4#�3��^?��E�NN�+h�A�t�/;�-(=�~#kW� ֔T���l��ʬ��@�5:dK0��S~���5c^xt(�m�A����*��QFcO���#�w��"��I��x`l{�0@s&�Pf'j�8,����{�$�,a���y�as�t)�S� ����[i
Zbk��L�)YC�����
��d�1��M�(�XT���+��M���y�1��X���H���ޏ����̣���.��;�+�j�E�b�Ǧ�f�)�ZO�.�ξCf7p�;�w_p=~0{�$~���ѧ⛖�}�< �C�������<��9�\��Sn[<�ЅX�8	 �Q�PF�-.����'�CTm	h�̰]BZ�"��e�N�ʤ��.�Ym����)�'�Y�F��eK��d��m�� �r����B�L���G�6?|s�2��t���GS�_~C[d�.yb���t~�+��n��N������Bq�l�|���B���i���Ҧ.����i���N    ��*^�:\��/`y�<���<cw9�X,Y���҃Tٰ:�v���L�ڱ੉7RfE&	%g��(�ȹ�~�$|�ے�vD�7]}s_�Zzq�67�,(�a���3�!fO޻�m믌�-ϫ�X�/����dDQ�*z0�5Ӆ�l����������
���J��*�<�.~��OOI%�&�۱'�g\�_�OXL�"��5�K���J�*p���#d���l �Z�T�¡��h.�R��HGp���瓝�,����	�뮾o�7.BY��p�ɮ̠�T2��j��	*F=%
�(=��vx9<1AE�*'Z��j��u�`���yr�p��HƃJ(��Z�M��� �_lZ��y��a�a)�,4�H�dy�Q9T�m,�/<"o��z
3���U�!dμ||��!�i�%�P��﵅+���>��;��tWO"ƒ�bt��7:c�A��������'�R���x�db���+����D�%%{�)�yn�P��%v��q9�0�i!xf��5z�B:���A3b=�B-�"���и%-n�^���' !tHM�d�~\7/k���S�T2�e|i�����1��. H+�����%�4nA.M���JX�&����e�<\�"z`���I�,"�[���`3q� ��{hA�,G��-I���1�������hɂ�0R4�Uuc?�� %vS2����c���;��6��/:ɸ0�h�AN�����l^���$�j]kK?G�y�޶^��L���v����:��� 9~�d���`K<��s/�w��<5�5@��g��14GD!��['SD�� � �c��ԢѴ(>س&��Fb� S�5O�׭s �"�'�;���\1��bs9�P޵��df.=7�|U^]4w��Nʾ���>mVنwEmѴy���7�+ȗoq��ƻ~�N��2�YR.���1��XeeN��:�˖P��=w�:�Ò5�(�}���[L�߱����7H�wM���:�`:�Hގ�y�>=���L��4-Ą�z&t�k�
.��V�ES�=՞h�W͝E�-�Ze_| <�T�����{�w�de�NAh�?xj����#�=���d�d]�����I�@F�����J�������}y�Or���#��{�t�Œ�C�b|����&X�l>l��&����������-�O�.V�V�XB���v= ~�����aA���-���0�Z��8&��_�Ǝ��Ch���+�@�3���Y����x��_�!�T�;�7$3Y��Y�4��W颙�j�����@��@��~@�1���Ν�Wbu]��\���d)�%�K��Rq XiG<� �H��/��H'GCkb�����9���p����x��kD�%ü�
�o=?����v�CI���}b�\�|)6�������-0c�]����f��<���7�h:b�Ҋ��<��X ��k��R�4> 'z�I�w�'냍����?]>u��"���`��9|+fۊ�}��|g��C"�@�!��'+��̑L���9ќ)�TS.����׸X�=D
�(4π�n���-YWp��2��5��v�n���$]�|P'D��N� 5cp����{̑�R1�E�!�ěv��y�_�=ds*�H��V��f+�t�H���+����6��<>L�Z>����@Ń*̬Ó�Au8 e6����7����&ؿM����Ճ���1��QW.�.,�Wt���_o�,���D��9 Brc�^I� W�dj\=�t���j�0$�e�r�H� P͹��l�:ı{-IO��^䀸h��ϩ��==ȗ}��P�\�[2̷ͫ�2?~!�m����a��>>*8"�o!:Ѩ77{�#&o�c1����xs�]d:����d������?;��[ZH�����Lj�a\GI�`0�P)^�磹����9�@mW���3�u?l,1AzEe��,_tk�󡺷��25݋���Ź��ḿpYH���t�兿�̉G�Y.��k��ݳ��c�Ja!�����^7�����Z�}�]5w����a'܀�T,���ვDtc�r��=�;�Z\��9p70��=G�ʄ����M�"yǲ��gk�{��qK ���߂Lष$�i �8ƻ�ak�����yЬO�zp�w#>f����#���z�|������%��N��(���kӪ���ŵK��O���Rc$I�ᳲU���)�=�ʸ*+2�n�l�s���OnM�vLJ�i��o������$�u��uP�?$@a�*3[Q�Q��!&:��6/�d�h�9"�P�ݿ�Z�z,�½>b�8���{`�-�b��1oH�qL1O$yK�o�X���4���gH�9z����ŀE��� :%Rč��FЙgm�7ԂSj� go���m}��m��L)�dگ荳Eu����F��
M�G�!J'S5�S�Ĭ�#)�nܒ���w��ٽ%uC"��h ����N-���@���g��O�r:�#f?h�;��%n�^�"���{����:o%���@�m瑘��e ����r�{_́��j6����e�Q����!�Y� ���5:X�ǌ�����`���o��t�B_��swm=��Lg�.�<,�>D
V��jzv�q�n0(�d�>&��X ���Y>? P�>maS5å'b�ż�����2V+�:"ڂu�
�3�q�k!�Id~����m�=�A�lA�?���H��ܽ��s�% Qp#8l���M��x�D��f�����%�j��<v�W�I�8*�\��P���(}"�{��W-�R�������!h���B,�?�6OcFJ:���[�/+����
���� ����q�w�b����P�:��u��ރ����>p���e	`��`�t����u4�,^1V<��v)Az� G���K�֣��
4�9�v�Hi07� k�f8A<�dG��Ĝ?F�u�䁋 �#C�
%���}DA��!�(��D�j�i��_ip\pM��b�~�g��;~����<�Z��9�;o�}��}�	�Ӆ�JK�{*!|��V!:��^�x]m]<�.k3�HM��Y�|[�Hu����o\L�ǪH43��������WEr>D~'�7h?Tf�vjR�m��C�~�D��BH��	�����܂�!���yS�f��	�J���wö��G�dz����~�dQ|M=�����H��U����aX�^��0���[atGMg�T��3�����{+�52�z���KhV�����vpzǾF�a~�,)�ާ�"�٨�?x)�oQQ*]���_��C��2��$Ha<��R�~E����)r�1|�!a4��K���f��%�c�N����]T��"8J����5}��^wϖ���q��]l~�ۂ� 2�f1Rp?T��1�cf�����Gxق,7+I����d�������Ҽxvn6�d��2�C3S���I���B��<µI���{D�CL��]�L�/��͢?���ڷtlᒅOZi�k'm��t���ͥ!�벞2a��y�l��C���##�������+i`E��k3����L2#����2�� �gsPP�z� T�>A��ʽg�>�?{WB����]�hJ'T��Z��'R�k�K�t��\_ŭ�$�Yy�O�iO�I�U���$� �g)rd����}&0�9�+ht�BX
Q<7N��g�=�\�#�9�(�$�T��7��%�C
	��pg�0U�Lqn\�3��Z�AMRñ�,����jp��h�x�K%�pr�@�F����yk%h��v��0�({���:]IQ�CQ,*͹������T%����.8����m�&�z�.�Q�>�i��;3	J�(��(���V������coa��L&x3�"Nc(��"CҬ�=Q���RQ�*px.��b�~�[��䁠�N|c�q|U_̋lT�@(��S#��	���/F��F�[�)=�D���A��F"�Y�s���Y�>!�Y��`��U1&�/.H�o��{��4J���ѡqĐ���TNsf��9؟	�W�E�w��sz_ 1>+   ��r�`�ãi�=&<��E����k�~>��⦵��yrz���X�p�䧰��X�̎�i�XxlH G��ϭS�;-,��3�R���Ő�,9Y��J���#���u���zH�R�)����e���ۚ����-|�b�����g��{վP�_鐑��u{�_��b ���1�d�'�̮|�n�yo��ݺl嫱��,��g|t�oz��t��"�l6�恐��eyd
jV
�����Ky�U�r�n��Y���doaA/�X��q��rL�ٴ�?�� ����L�j�F�S�Q�Gk$:g�Zs�\�Oy�W�i�,(�sJr�<bVF���$��Z "��'�䊹7���W�]��6�����yo��S��+���O/��	X�s�+��j�1�rHU�¼^�w��{u\A %\0綺����Y�V��H�}��>q��8NU"�����ا�i粛FDѵ��rdp̒<' ++Q�,21��&����9�f�nooV�FCO���ֹ� �$�ﴙo�oM�aRC�8|��Gr��� )�T%mg1NZ��g���SWժ����)���F�D�0��n�_��l`�qӷ�]Ã|�_!?�����4��]�<Ȫ�X㔂B��7��
�ℋ-/+�c�ry{cV��曜��4w�w	�5�jbU�{��;"?gB�[�F&)�^�x�c�}���\��/�QZ@Ha�n�c"o�6�;k��L�3�v��xD���d��81j2�6/4ZP
�B������br,��^���
iY�2�f';E���� G�'[A�`�*E������"��}��P��h4G��}��F�a��6�,L��D7�x7F�w9q_l{��zo]Xp
��?}%}
��Q>~0DؓW����͸,� .�tcZP2G�|`60c�<B�B<�j�P���w�-�=p�½j4���k�-�S+.����@�Y��E@���z���Z�r�)S�V��6ޢ(�H((��N2x[R!�֚��R:��x��
+���;��Y�%���By(��}�����Pd·�R��$�T�=��vy�uT%�)�H7ʮgHL�#��<��$�+��Е���i!sJ|$0�tUvG
��ԫ޻�IXΙ�G5�I����E뭽P2�>��Z�`�4���t�x�B�� �Zw8ڱ��d����郹g-��C{uD�y�:,Ҩ�%�xeE�jN�/���N��i����]�
�����r�3�8��w��m&K<t؊$$��x��(�X�P�%�u@�ah6YFK�h}͟��+b�.2������K�(U���.� ��". $Q����׫��E����m��▮c�h��v��A��@��hR�H�?m�\��}�IV�~6��#��_D�� ]��
��/������)w�H������5�t��Cv��%Fs|Bꃆ���*�@�Ζ����໕*�]x'skP��u��,���`�R!A�b��o9e]�@ `�N!�UO;�!�*\�:�����==�4�Z.�:uS)?r�	
���7�Y	���?@�M�mB>ǻ�{d�tgF���\�z���rPk?��.cM��|�-|>���`��Y��*kj!l���1�ȗ�)�[�śor��dB��o/�D��q'e���ߥ�*�'��U��`���[��<އ���ت�%A��EC3�=�!gf��/���"����̧&�%���1_�!G!hNl͌$$����f�Z��?��9N�k|�j�f���@)|��F����9k��fp[��$]vi���!��
��wʞ�(��Sa��D7�;��&g���寱x���Tn��y���#�Z�9k�^=�*���?M�Jg>�%{��p�����U)����*�r3O���&� ���+�&��w�m�^��5��>l�R�ueI\� I�!n�-�/.,q�FD�5�+��=�:=�44/ᩛɯ�Ac�vLkR� �lʆU�d�?>����c��\���ᤂC�SP���L-���b�T������-���            x^����� � �            x^����� � �         $   x^32�4�4661����4�22rM,�!�=... _�P          7   x^3�L�LtH�M���K����Lt́H��������\�����Ҍ+F��� <f            x^����� � �            x^����� � �            x^����� � �     