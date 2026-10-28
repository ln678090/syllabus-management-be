CREATE TABLE file_minh_chungs (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,
    phien_ban_de_cuong_id UUID,

    file_name VARCHAR(500) NOT NULL,
    file_url TEXT NOT NULL,

    uploaded_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_file_minh_chungs
        PRIMARY KEY (id),

    CONSTRAINT fk_file_minh_chungs_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_file_minh_chungs_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_file_minh_chungs_uploaded_by
        FOREIGN KEY (uploaded_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_file_minh_chungs_ke_hoach
    ON file_minh_chungs(ke_hoach_xay_dung_id);

CREATE INDEX idx_file_minh_chungs_phien_ban
    ON file_minh_chungs(phien_ban_de_cuong_id);
