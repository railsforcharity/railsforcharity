--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer,
    provider character varying(255),
    uid character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: avatars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE avatars (
    id integer NOT NULL,
    avatarable_type character varying(255),
    avatarable_id integer,
    image character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: avatars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE avatars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avatars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE avatars_id_seq OWNED BY avatars.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    content text,
    commentable_id integer,
    commentable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying(255),
    created_by integer
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    address_line1 character varying(255),
    address_line2 character varying(255),
    city character varying(255),
    state character varying(255),
    postal character varying(255),
    country character varying(255),
    locatable_type character varying(255),
    locatable_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE preferences (
    id integer NOT NULL,
    user_id integer,
    entity_id integer,
    entity_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    properties hstore
);


--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE preferences_id_seq OWNED BY preferences.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    title character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_by integer,
    website character varying(255),
    profile_url character varying(255),
    status character varying(255),
    video character varying(255)
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: rs_evaluations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rs_evaluations (
    id integer NOT NULL,
    reputation_name character varying(255),
    source_id integer,
    source_type character varying(255),
    target_id integer,
    target_type character varying(255),
    value double precision DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rs_evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rs_evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rs_evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rs_evaluations_id_seq OWNED BY rs_evaluations.id;


--
-- Name: rs_reputation_messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rs_reputation_messages (
    id integer NOT NULL,
    sender_id integer,
    sender_type character varying(255),
    receiver_id integer,
    weight double precision DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rs_reputation_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rs_reputation_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rs_reputation_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rs_reputation_messages_id_seq OWNED BY rs_reputation_messages.id;


--
-- Name: rs_reputations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rs_reputations (
    id integer NOT NULL,
    reputation_name character varying(255),
    value double precision DEFAULT 0,
    aggregated_by character varying(255),
    target_id integer,
    target_type character varying(255),
    active boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rs_reputations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rs_reputations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rs_reputations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rs_reputations_id_seq OWNED BY rs_reputations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: skills; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE skills (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    category character varying(255),
    is_deprecated boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE skills_id_seq OWNED BY skills.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    taggable_id integer,
    taggable_type character varying(255),
    tag_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tag_type character varying(255),
    color character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    description text,
    task_type character varying(255),
    status integer,
    estimated_time integer,
    project_id integer,
    created_by integer,
    assigned_to integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_permissions (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying(255),
    role_id integer,
    entity_type character varying(255),
    entity_id integer
);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_permissions_id_seq OWNED BY user_permissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    bio text,
    website character varying(255),
    slug character varying(255),
    user_type integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY avatars ALTER COLUMN id SET DEFAULT nextval('avatars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY preferences ALTER COLUMN id SET DEFAULT nextval('preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rs_evaluations ALTER COLUMN id SET DEFAULT nextval('rs_evaluations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rs_reputation_messages ALTER COLUMN id SET DEFAULT nextval('rs_reputation_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rs_reputations ALTER COLUMN id SET DEFAULT nextval('rs_reputations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY skills ALTER COLUMN id SET DEFAULT nextval('skills_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_permissions ALTER COLUMN id SET DEFAULT nextval('user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: avatars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY avatars
    ADD CONSTRAINT avatars_pkey PRIMARY KEY (id);


--
-- Name: collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_permissions
    ADD CONSTRAINT collaborators_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: email_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY preferences
    ADD CONSTRAINT email_preferences_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: rs_evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rs_evaluations
    ADD CONSTRAINT rs_evaluations_pkey PRIMARY KEY (id);


--
-- Name: rs_reputation_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rs_reputation_messages
    ADD CONSTRAINT rs_reputation_messages_pkey PRIMARY KEY (id);


--
-- Name: rs_reputations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rs_reputations
    ADD CONSTRAINT rs_reputations_pkey PRIMARY KEY (id);


--
-- Name: skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_comments_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_ancestry ON comments USING btree (ancestry);


--
-- Name: index_rs_evaluations_on_reputation_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_evaluations_on_reputation_name ON rs_evaluations USING btree (reputation_name);


--
-- Name: index_rs_evaluations_on_reputation_name_and_source_and_target; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_rs_evaluations_on_reputation_name_and_source_and_target ON rs_evaluations USING btree (reputation_name, source_id, source_type, target_id, target_type);


--
-- Name: index_rs_evaluations_on_source_id_and_source_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_evaluations_on_source_id_and_source_type ON rs_evaluations USING btree (source_id, source_type);


--
-- Name: index_rs_evaluations_on_target_id_and_target_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_evaluations_on_target_id_and_target_type ON rs_evaluations USING btree (target_id, target_type);


--
-- Name: index_rs_reputation_messages_on_receiver_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_reputation_messages_on_receiver_id ON rs_reputation_messages USING btree (receiver_id);


--
-- Name: index_rs_reputation_messages_on_receiver_id_and_sender; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_rs_reputation_messages_on_receiver_id_and_sender ON rs_reputation_messages USING btree (receiver_id, sender_id, sender_type);


--
-- Name: index_rs_reputation_messages_on_sender_id_and_sender_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_reputation_messages_on_sender_id_and_sender_type ON rs_reputation_messages USING btree (sender_id, sender_type);


--
-- Name: index_rs_reputations_on_reputation_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_reputations_on_reputation_name ON rs_reputations USING btree (reputation_name);


--
-- Name: index_rs_reputations_on_reputation_name_and_target; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_rs_reputations_on_reputation_name_and_target ON rs_reputations USING btree (reputation_name, target_id, target_type);


--
-- Name: index_rs_reputations_on_target_id_and_target_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rs_reputations_on_target_id_and_target_type ON rs_reputations USING btree (target_id, target_type);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);


--
-- Name: preferences_properties; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX preferences_properties ON preferences USING gin (properties);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120806064945');

INSERT INTO schema_migrations (version) VALUES ('20120828234929');

INSERT INTO schema_migrations (version) VALUES ('20120902001824');

INSERT INTO schema_migrations (version) VALUES ('20120902131112');

INSERT INTO schema_migrations (version) VALUES ('20120902192055');

INSERT INTO schema_migrations (version) VALUES ('20120903061809');

INSERT INTO schema_migrations (version) VALUES ('20120906011451');

INSERT INTO schema_migrations (version) VALUES ('20120907012840');

INSERT INTO schema_migrations (version) VALUES ('20120907015507');

INSERT INTO schema_migrations (version) VALUES ('20120908031104');

INSERT INTO schema_migrations (version) VALUES ('20120908031105');

INSERT INTO schema_migrations (version) VALUES ('20120908031106');

INSERT INTO schema_migrations (version) VALUES ('20120908031107');

INSERT INTO schema_migrations (version) VALUES ('20120908031108');

INSERT INTO schema_migrations (version) VALUES ('20120908031109');

INSERT INTO schema_migrations (version) VALUES ('20120908031110');

INSERT INTO schema_migrations (version) VALUES ('20120908183537');

INSERT INTO schema_migrations (version) VALUES ('20120909055820');

INSERT INTO schema_migrations (version) VALUES ('20120909055842');

INSERT INTO schema_migrations (version) VALUES ('20120909194435');

INSERT INTO schema_migrations (version) VALUES ('20120909195624');

INSERT INTO schema_migrations (version) VALUES ('20120909200426');

INSERT INTO schema_migrations (version) VALUES ('20120914015637');

INSERT INTO schema_migrations (version) VALUES ('20120918235344');

INSERT INTO schema_migrations (version) VALUES ('20120920054343');

INSERT INTO schema_migrations (version) VALUES ('20120920073643');

INSERT INTO schema_migrations (version) VALUES ('20120923062555');

INSERT INTO schema_migrations (version) VALUES ('20120928001805');

INSERT INTO schema_migrations (version) VALUES ('20120929225158');

INSERT INTO schema_migrations (version) VALUES ('20120929225922');

INSERT INTO schema_migrations (version) VALUES ('20121007000758');

INSERT INTO schema_migrations (version) VALUES ('20121011080031');

INSERT INTO schema_migrations (version) VALUES ('20121016070546');

INSERT INTO schema_migrations (version) VALUES ('20121018031834');

INSERT INTO schema_migrations (version) VALUES ('20121018032248');

INSERT INTO schema_migrations (version) VALUES ('20121022145507');

INSERT INTO schema_migrations (version) VALUES ('20121027191731');

INSERT INTO schema_migrations (version) VALUES ('20121029074448');

INSERT INTO schema_migrations (version) VALUES ('20121119225226');

INSERT INTO schema_migrations (version) VALUES ('20130117010133');