CREATE TABLE buoi_hocs (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,

    so_buoi INT NOT NULL,
    chu_de TEXT NOT NULL,

    -- Learning-Teaching Method - Phuong phap day va hoc
    learning_teaching_method VARCHAR(255),

    -- ITU - Muc do I/T/U cua noi dung hoc
    itu VARCHAR(50),

    tai_lieu_sinh_vien TEXT,
    tai_lieu_giang_vien TEXT,

    hoat_dong_sinh_vien TEXT,
    nhiem_vu_giang_vien TEXT,

    student_download TEXT,
    teacher_download TEXT,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_buoi_hocs
        PRIMARY KEY (id),

    CONSTRAINT fk_buoi_hocs_phien_ban_de_cuong
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_buoi_hocs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_buoi_hocs_phien_ban_so_buoi
        UNIQUE (phien_ban_de_cuong_id, so_buoi),

    CONSTRAINT uq_buoi_hocs_id_phien_ban
        UNIQUE (id, phien_ban_de_cuong_id)
);

CREATE INDEX idx_buoi_hocs_phien_ban_de_cuong
    ON buoi_hocs(phien_ban_de_cuong_id);
