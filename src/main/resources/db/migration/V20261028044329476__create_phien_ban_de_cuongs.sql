CREATE TABLE phien_ban_de_cuongs (
    id UUID NOT NULL,

    de_cuong_id UUID NOT NULL,
    chuong_trinh_id UUID,

    version_number INT NOT NULL,

    document_type VARCHAR(50),
    so_quyet_dinh VARCHAR(100),

    -- Learning-Teaching Method - Phuong phap day va hoc
    learning_teaching_method TEXT,

    so_tin_chi NUMERIC(4,1),
    bac_dao_tao VARCHAR(100),

    -- Time Allocation - Phan bo thoi gian hoc
    time_allocation TEXT,

    -- Pre-Requisite - Dieu kien tien quyet
    pre_requisite TEXT,

    description TEXT,

    -- Student Tasks - Nhiem vu cua sinh vien
    student_tasks TEXT,

    tools TEXT,
    note TEXT,

    -- Minimum GPA to pass - Diem toi thieu de qua mon
    min_gpa_to_pass NUMERIC(5,2),

    -- Scoring Scale - Thang diem
    scoring_scale NUMERIC(5,2),

    approved_date DATE,

    -- Version locking
    is_locked BOOLEAN NOT NULL DEFAULT FALSE,
    locked_at TIMESTAMPTZ,
    locked_by UUID,

    created_by UUID,
    updated_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_phien_ban_de_cuongs
        PRIMARY KEY (id),

    CONSTRAINT fk_phien_ban_de_cuongs_de_cuong
        FOREIGN KEY (de_cuong_id)
        REFERENCES de_cuongs(id),

    CONSTRAINT fk_phien_ban_de_cuongs_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id),

    CONSTRAINT fk_phien_ban_de_cuongs_locked_by
        FOREIGN KEY (locked_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_phien_ban_de_cuongs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_phien_ban_de_cuongs_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_phien_ban_de_cuongs_version
        UNIQUE (de_cuong_id, version_number),

    CONSTRAINT ck_phien_ban_de_cuongs_version
        CHECK (version_number > 0),

    CONSTRAINT ck_phien_ban_de_cuongs_locked
        CHECK (
            (is_locked = FALSE AND locked_at IS NULL AND locked_by IS NULL)
            OR
            (is_locked = TRUE AND locked_at IS NOT NULL)
        )
);

CREATE INDEX idx_phien_ban_de_cuongs_de_cuong
    ON phien_ban_de_cuongs(de_cuong_id);

CREATE INDEX idx_phien_ban_de_cuongs_chuong_trinh
    ON phien_ban_de_cuongs(chuong_trinh_id);

CREATE INDEX idx_phien_ban_de_cuongs_is_locked
    ON phien_ban_de_cuongs(is_locked);
