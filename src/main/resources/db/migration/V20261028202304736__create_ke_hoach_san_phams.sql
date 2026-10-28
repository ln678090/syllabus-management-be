CREATE TABLE ke_hoach_san_phams (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,
    loai_san_pham_id UUID NOT NULL,

    sort_order INT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_ke_hoach_san_phams
        PRIMARY KEY (id),

    CONSTRAINT fk_khsp_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_khsp_loai_san_pham
        FOREIGN KEY (loai_san_pham_id)
        REFERENCES loai_san_phams(id),

    CONSTRAINT uq_khsp_ke_hoach_loai
        UNIQUE (
            ke_hoach_xay_dung_id,
            loai_san_pham_id
        ),

    CONSTRAINT uq_khsp_ke_hoach_order
        UNIQUE (
            ke_hoach_xay_dung_id,
            sort_order
        ),

    CONSTRAINT ck_khsp_sort_order
        CHECK (sort_order > 0)
);

CREATE INDEX idx_khsp_ke_hoach
    ON ke_hoach_san_phams(ke_hoach_xay_dung_id);
