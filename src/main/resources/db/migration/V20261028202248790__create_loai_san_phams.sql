CREATE TABLE loai_san_phams (
    id UUID NOT NULL,

    code VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,

    CONSTRAINT pk_loai_san_phams
        PRIMARY KEY (id),

    CONSTRAINT uq_loai_san_phams_code
        UNIQUE (code)
);
