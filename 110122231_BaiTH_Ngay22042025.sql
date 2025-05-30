CREATE DATABASE QUANLY_SINHVIEN
USE QUANLY_SINHVIEN

CREATE TABLE KHOA(
	MaKhoa char(4) not null,
	TenKhoa nvarchar(30),
	Diachi nvarchar(50),
	DienThoai varchar(10)
	);
GO
ALTER TABLE KHOA ADD CONSTRAINT PK_KHOA PRIMARY KEY(MaKhoa)
GO
CREATE TABLE LOP(
	MaLop char(10) NOT NULL,
	TenLop nvarchar(30),
	MaKhoa char(4) not null
	);
GO
ALTER TABLE LOP ADD CONSTRAINT PK_LOP PRIMARY KEY(MaLop)
ALTER TABLE LOP ADD CONSTRAINT FK_KHOA_LOP FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)
GO
CREATE TABLE SINHVIEN (
    MaSV CHAR(8) NOT NULL,
    HoTenSV NVARCHAR(30),
    NgaySinh DATETIME,
    MaLop CHAR(10)NOT NULL
);
GO
ALTER TABLE SINHVIEN ADD CONSTRAINT PK_SINHVIEN PRIMARY KEY(MaSV)
ALTER TABLE SINHVIEN ADD CONSTRAINT FK_SINHVIEN_LOP FOREIGN KEY(MaLop) REFERENCES LOP(MaLop)
GO
CREATE TABLE MONHOC (
    MaMon VARCHAR(5) NOT NULL,
    TenMon NVARCHAR(30),
    SoTinChi SMALLINT
);
GO
ALTER TABLE MONHOC ADD CONSTRAINT PK_MONHOC PRIMARY KEY(MaMon)
GO
CREATE TABLE GIANGVIEN (
    MaGV CHAR(9) NOT NULL,
    HoTenGV NVARCHAR(40),
    MaKhoa CHAR(4)
);
GO
ALTER TABLE GIANGVIEN ADD CONSTRAINT PK_GIANGVIEN PRIMARY KEY(MaGV)
ALTER TABLE GIANGVIEN ADD CONSTRAINT FK_GIANGVIEN_KHOA FOREIGN KEY(MaKhoa) REFERENCES KHOA(MaKhoa)
GO
CREATE TABLE GIANGDAY (
    MaMon VARCHAR(5)NOT NULL,
    MaGV CHAR(9)NOT NULL,
    NamHoc CHAR(9)NOT NULL,
    Hocky SMALLINT NOT NULL,
    MaLop CHAR(10)NOT NULL,
);
GO
ALTER TABLE GIANGDAY ADD CONSTRAINT PK_GIANGDAY PRIMARY KEY(MaMon, MaGV, NamHoc, Hocky, MaLop)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY_MONHOC FOREIGN KEY(MaMon) REFERENCES MONHOC(MaMon)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY_GIANGVIEN FOREIGN KEY(MaGV) REFERENCES GIANGVIEN(MaGV)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY_LOP FOREIGN KEY(MaLop) REFERENCES LOP(MaLop)
GO
DROP TABLE DANGKYHOC
CREATE TABLE DANGKYHOC (
    MaSV CHAR(8)NOT NULL,
    MaMon VARCHAR(5)NOT NULL,
    NamHoc CHAR(9)NOT NULL,
    Hocky SMALLINT NOT NULL,
    MaGV CHAR(9)NOT NULL,
    Diem SMALLINT
);
GO
ALTER TABLE DANGKYHOC ADD CONSTRAINT PK_DANGKYHOC PRIMARY KEY(MaSV, MaMon, NamHoc, Hocky, MaGV)
ALTER TABLE DANGKYHOC ADD CONSTRAINT FK_DANGKYHOC_SINHVIEN FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV)
ALTER TABLE DANGKYHOC ADD CONSTRAINT FK_DANGKYHOC_MONHOC FOREIGN KEY (MaMon) REFERENCES MONHOC(MaMon)
ALTER TABLE DANGKYHOC ADD CONSTRAINT FK_DANGKYHOC_GIANGVIEN FOREIGN KEY (MaGV) REFERENCES GIANGVIEN(MaGV)
--ALTER TABLE DANGKYHOC ADD CONSTRAINT FK_DANGKYHOC_NAMHOC FOREIGN KEY (NamHoc) REFERENCES GIANGDAY(NamHoc)
--ALTER TABLE DANGKYHOC ADD CONSTRAINT FK_DANGKYHOC_HOCKY FOREIGN KEY (Hocky) REFERENCES GIANGDAY(Hocky)
GO

----------------------------------------------------------------------------------------------------------------
--III./ Viết lệnh nhập dữ liệu cho các bảng có trong cơ sở dữ liệu:
INSERT INTO KHOA (MaKhoa, TenKhoa, Diachi, DienThoai) VALUES
('TOAN',  N'Toán - Tin',               N'Nhà C1', '0743447325'),
('CNTT',  N'Công nghệ Thông tin',      N'Nhà C2', '0743447326'),
('D_LY',  N'Địa lý',                   N'Nhà A1', '0743447327'),
('HHOC',  N'Hóa học',                  N'Nhà A2', '743328');

INSERT INTO LOP (MaLop, TenLop, MaKhoa) VALUES
('DA11TO12A1', N'ĐH Toán A1 2012', 'TOAN'),
('DA12TT12A1', N'ĐH CNTT A1 2012', 'CNTT'),
('DA12DL12A1', N'ĐH Địa lý A1 2012', 'D_LY'),
('DA12TT12A2', N'ĐH CNTT A2 2012', 'CNTT'),
('DA12DL12A2', N'ĐH Địa lý A2 2012', 'D_LY'),
('DA12HH12A1', N'ĐH Hóa học A1 2012', 'HHOC');

INSERT INTO SINHVIEN (MaSV, HoTenSV, NgaySinh, MaLop) VALUES
('K6100001', N'Phạm Văn Bình', '1990-02-24', 'DA11TO12A1'),
('K6100002', N'Nguyễn Thị Hoài Thu', '1991-04-12', 'DA12TT12A1'),
('K6100003', N'Trần Ngọc Thanh', '1990-04-15', 'DA12DL12A1'),
('K6100004', N'Nguyễn Tấn Hùng', '1992-02-03', 'DA12TT12A2'),
('K6100005', N'Trương Thành Sang', '1990-12-04', 'DA12DL12A2'),
('K6100006', N'Nguyễn Anh Dũng', '1982-03-03', 'DA12HH12A1'),
('K6100007', N'Phạm Hồng Ánh', '1990-02-24', 'DA11TO12A1'),
('K6100008', N'Lê Thị Liễu', '1991-04-12', 'DA12TT12A1'),
('K6100009', N'Phạm Ngọc Sương', '1990-04-17', 'DA12DL12A1'),
('K6100010', N'Nguyễn Tần', '1992-12-03', 'DA12TT12A2'),
('K6100011', N'Thạch Thanh Sang', '1990-02-04', 'DA12DL12A2'),
('K6100012', N'Nguyễn Hồng Anh Ngọc', '1992-12-03', 'DA12HH12A1'),
('K6100013', N'Nguyễn Hồng Ngọc', '1992-12-13', 'DA12TT12A2'),
('K6100014', N'Kim Thanh Sang', '1990-02-04', 'DA12DL12A2'),
('K6100015', N'Hồng Anh Ngọc', '1992-12-13', 'DA12HH12A1');

INSERT INTO MONHOC (MaMon, TenMon, SoTinChi) VALUES
('GTA1', N'Giải tích 1', 2),
('DSTT', N'Đại số tuyến tính', 3),
('HHAF', N'Hình học Afin', 2),
('XSTK', N'Xác suất thống kê', 2);
INSERT INTO MONHOC (MaMon, TenMon, SoTinChi) VALUES
('THDC', N'Tin học đại cương', 3),
('KTLT', N'Kỹ thuật lập trình', 2);

INSERT INTO GIANGVIEN (MaGV, HoTenGV, MaKhoa) VALUES
('15.111.01', N'Phạm Bình Minh', 'TOAN'),
('15.111.02', N'Nguyễn Hoài Thu', 'CNTT'),
('15.111.03', N'Trần Ngọc Ân', 'D_LY'),
('15.111.04', N'Nguyễn Hùng Anh', 'HHOC'),
('15.111.05', N'Phạm Ngộc Diệp', 'TOAN'),
('15.111.06', N'Lê Anh Dũng', 'CNTT'),
('15.111.07', N'Phạm Hồng Ánh', 'TOAN'),
('15.111.08', N'Lê Thị Liễu Phượng', 'HHOC'),
('15.111.09', N'Phạm Ngọc Thu Sương', 'CNTT'),
('15.111.10', N'Võ Anh Tài', 'CNTT');

INSERT INTO GIANGDAY (MaMon, MaGV, NamHoc, Hocky, MaLop) VALUES
('GTA1', '15.111.01', '2012-2013', 1, 'DA11TO12A1'),
('DSTT', '15.111.05', '2012-2013', 2, 'DA11TO12A1'),
('HHAF', '15.111.07', '2012-2013', 2, 'DA11TO12A1'),
('XSTK', '15.111.01', '2011-2012', 2, 'DA12HH12A1'),
('THDC', '15.111.10', '2012-2013', 1, 'DA12DL12A1'),
('THDC', '15.111.09', '2011-2012', 1, 'DA12HH12A1'),
('THDC', '15.111.02', '2012-2013', 1, 'DA12DL12A2'),
('KTLT', '15.111.02', '2012-2013', 2, 'DA12TT12A1');

INSERT INTO DANGKYHOC (MaSV, MaMon, NamHoc, Hocky, MaGV, Diem) VALUES
('K6100001', 'GTA1', '2012-2013', 1, '15.111.01', 6),
('K6100001', 'DSTT', '2012-2013', 2, '15.111.05', 7),
('K6100001', 'HHAF', '2012-2013', 2, '15.111.07', 5),
('K6100002', 'DSTT', '2012-2013', 2, '15.111.05', 4),
('K6100002', 'XSTK', '2011-2012', 2, '15.111.01', 3);

INSERT INTO DANGKYHOC (MaSV, MaMon, NamHoc, Hocky, MaGV, Diem) VALUES
('K6100002', 'GTA1', '2012-2013', 1, '15.111.01', 2),
('K6100003', 'HHAF', '2012-2013', 2, '15.111.07', 5),
('K6100003', 'GTA1', '2012-2013', 1, '15.111.01', 9),
('K6100003', 'XSTK', '2011-2012', 2, '15.111.01', 10),
('K6100004', 'XSTK', '2011-2012', 2, '15.111.01', 4),
('K6100004', 'DSTT', '2012-2013', 2, '15.111.05', 7),
('K6100004', 'KTLT', '2012-2013', 2, '15.111.02', 5),
('K6100012', 'THDC', '2012-2013', 1, '15.111.10', 6),
('K6100013', 'THDC', '2011-2012', 1, '15.111.09', 9),
('K6100013', 'KTLT', '2012-2013', 2, '15.111.02', 8),
('K6100014', 'THDC', '2012-2013', 1, '15.111.02', 10),
('K6100015', 'THDC', '2012-2013', 1, '15.111.02', 3),
('K6100015', 'GTA1', '2012-2013', 1, '15.111.01', 6),
('K6100015', 'DSTT', '2011-2012', 1, '15.111.05', 7),
('K6100015', 'XSTK', '2012-2013', 1, '15.111.01', 8);

----------------------------------------------------------------------------------------------------------------
--II./ Viết Trigger để kiểm tra các ràng buộc toàn vẹn cho các trường hợp thao tác trên dữ liệu
--Kiểm tra Số điện thoại có đủ 10 số không
	CREATE TRIGGER trg_CheckSDT
	ON KHOA
	AFTER INSERT
	AS
	BEGIN
		-- Kiểm tra nếu số điện thoại có độ dài không phải là 10 ký tự
		IF EXISTS (
			SELECT 1
			FROM inserted
			WHERE LEN(DienThoai) != 10
		)
		BEGIN
			-- Gây lỗi nếu không đúng điều kiện
			RAISERROR('Số điện thoại phải có đúng 10 chữ số', 16, 1);
			ROLLBACK; -- Hoàn tác thao tác insert
		END
	END;
	GO
--Không cho xóa các thông tin trong bảng Lop
	CREATE TRIGGER trg_PreventDeleteOnLOP
	ON LOP
	INSTEAD OF DELETE
	AS
	BEGIN
		-- Gây lỗi nếu cố gắng xóa dữ liệu trong bảng LOP
		RAISERROR('Không thể xóa dữ liệu trong bảng LOP!', 16, 1);
	END;
	GO
--Khong cho thêm sinh viên dưới 18 và trên 30 tuổi
	CREATE TRIGGER trg_CheckAgeOnInsert
	ON SINHVIEN
	INSTEAD OF INSERT
	AS
	BEGIN
		DECLARE @NgaySinh DATETIME;
		DECLARE @MaSV CHAR(8);
	    
		-- Lấy thông tin ngày sinh và mã sinh viên từ dữ liệu đang chèn
		SELECT @NgaySinh = NgaySinh, @MaSV = MaSV FROM INSERTED;

		-- Kiểm tra tuổi của sinh viên (nếu tuổi < 18 hoặc > 30)
		IF DATEDIFF(YEAR, @NgaySinh, GETDATE()) < 18 OR DATEDIFF(YEAR, @NgaySinh, GETDATE()) > 30
		BEGIN
			RAISERROR('Sinh viên phải có độ tuổi từ 18 đến 30!', 16, 1);
		END
		ELSE
		BEGIN
			-- Nếu tuổi hợp lệ, thực hiện thao tác chèn
			INSERT INTO SINHVIEN (MaSV, HoTenSV, NgaySinh, MaLop)
			SELECT MaSV, HoTenSV, NgaySinh, MaLop FROM INSERTED;
		END
	END;
	GO
--Không cho thêm giảng viên ngoài khoa có trong CSDL
	CREATE TRIGGER trg_CheckMaKhoaOnInsert
	ON GIANGVIEN
	INSTEAD OF INSERT
	AS
	BEGIN
		DECLARE @MaKhoa CHAR(4);
	    
		-- Lấy mã khoa từ dữ liệu đang chèn
		SELECT @MaKhoa = MaKhoa FROM INSERTED;

		-- Kiểm tra xem mã khoa có tồn tại trong bảng KHOA không
		IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MaKhoa = @MaKhoa)
		BEGIN
			RAISERROR('Khoa không tồn tại trong cơ sở dữ liệu!', 16, 1);
		END
		ELSE
		BEGIN
			-- Nếu khoa tồn tại, thực hiện thao tác chèn
			INSERT INTO GIANGVIEN (MaGV, HoTenGV, MaKhoa)
			SELECT MaGV, HoTenGV, MaKhoa FROM INSERTED;
		END
	END;
	GO
--Không cho sửa khoa của giảng viên thành khóa không có trong sơ sở dữ liệu
	CREATE TRIGGER trg_PreventUpdateMaKhoa
	ON GIANGVIEN
	FOR UPDATE
	AS
	BEGIN
		DECLARE @OldMaKhoa CHAR(4), @NewMaKhoa CHAR(4);
	    
		-- Lấy mã khoa cũ và mới
		SELECT @OldMaKhoa = MaKhoa FROM DELETED;
		SELECT @NewMaKhoa = MaKhoa FROM INSERTED;

		-- Kiểm tra nếu mã khoa mới không tồn tại trong bảng KHOA
		IF @OldMaKhoa <> @NewMaKhoa AND NOT EXISTS (SELECT 1 FROM KHOA WHERE MaKhoa = @NewMaKhoa)
		BEGIN
			RAISERROR('Khoa mới không tồn tại trong cơ sở dữ liệu!', 16, 1);
		END
	END;
	GO
-- Không cho thêm điểm sinh viên <0 và >10
	CREATE TRIGGER trg_CheckDiemOnInsert
	ON DANGKYHOC
	INSTEAD OF INSERT
	AS
	BEGIN
		DECLARE @Diem SMALLINT;
	    
		-- Lấy giá trị điểm từ dữ liệu đang chèn
		SELECT @Diem = Diem FROM INSERTED;

		-- Kiểm tra nếu điểm không hợp lệ (dưới 0 hoặc trên 10)
		IF @Diem < 0 OR @Diem > 10
		BEGIN
			RAISERROR('Điểm phải nằm trong khoảng từ 0 đến 10!', 16, 1);
		END
		ELSE
		BEGIN
			-- Nếu điểm hợp lệ, thực hiện thao tác chèn
			INSERT INTO DANGKYHOC (MaSV, MaMon, NamHoc, Hocky, MaGV, Diem)
			SELECT MaSV, MaMon, NamHoc, Hocky, MaGV, Diem FROM INSERTED;
		END
	END;
	GO

--KIỂM TRA TRIGGER
	INSERT INTO KHOA (MaKhoa, TenKhoa, Diachi, DienThoai)
	VALUES ('TOAG', N'Toán - Tin', 'Nhà C1', '074344732'); --Loi sdt khong du 10 so

--IV./ Thực hiện cấp phát quyền cho người dùng truy cập vào cơ sở dữ liệu trên
USE QUANLY_SINHVIEN
-- quyền admin
	CREATE LOGIN Giangvien WITH PASSWORD = '123';
	create user GV_admin for login Giangvien
-- quyền user
	CREATE LOGIN Sinhvien WITH PASSWORD = '123';
	create user SV_user for login Sinhvien
-- quản trị
	CREATE LOGIN Quantri WITH PASSWORD = '123';
	CREATE USER quantri1 FOR LOGIN Quantri;
	GO


--Cấp quyền cho sinh viên chỉ được xem bảng DangKyHoc và thu hồi tất cả các quyền Thêm, Sửa, Xóa

-- Cấp quyền SELECT cho người dùng SV_user để xem dữ liệu trong bảng DANGKYHOC
GRANT SELECT ON DANGKYHOC TO SV_user;

-- Thu hồi quyền INSERT, UPDATE, DELETE trên bảng DANGKYHOC cho người dùng SV_user
REVOKE INSERT, UPDATE, DELETE ON DANGKYHOC TO SV_user;
--Login bằng tài khoản sinh viên và thực hiện câu lệnh sau:
	SELECT*FROM DANGKYHOC --Xem được
	DELETE FROM DANGKYHOC WHERE MaSV = 'K6100001' --Lỗi không có quyền để xóa "The DELETE permission was denied on the object 'DANGKYHOC', database 'QUANLY_NHANVIEN', schema 'dbo'."
-- Cấp quyền INSERT, UPDATE, DELETE cho người dùng GV_admin trên bảng DANGKYHOC
GRANT SELECT, INSERT, UPDATE, DELETE ON DANGKYHOC TO GV_admin;
--Login bằng tài khoản sinh viên và thực hiện câu lệnh sau:
	SELECT*FROM DANGKYHOC --Xem được
	DELETE FROM DANGKYHOC WHERE MaSV = 'K6100001' --Xóa được
	UPDATE DANGKYHOC SET Diem = 9 WHERE MaSV = 'K6100002' --Sửa được
--VI./ Viết view thực hiện các yêu cầu sau
	--1.Hiển thị danh sách tất cả các sinh viên
	CREATE VIEW XEMM_DS_SINHVIEN
	AS
	SELECT * FROM SINHVIEN
	SELECT * FROM XEMM_DS_SINHVIEN
	--2.Hiển thị danh sách tất cả các sinh viên(Họ tên sinh viên, tên lớp, tên khoa)
	CREATE VIEW XEMM_DS_SINHVIEN2
	AS
	SELECT SINHVIEN.HoTenSV, LOP.TenLop, KHOA.TenKhoa 
	FROM SINHVIEN INNER JOIN LOP ON SINHVIEN.MaLop = LOP.MaLop
					INNER JOIN KHOA ON LOP.MaKhoa = KHOA.MaKhoa
	SELECT * FROM XEMM_DS_SINHVIEN2
	--3.Hiển thị danh sách tất cả các giảng viên (họ tên giảng viên, tên khoa)
	CREATE VIEW XEMM_DS_GIANGVIEN
	AS
	SELECT GIANGVIEN.HoTenGV, KHOA.TenKhoa 
	FROM GIANGVIEN INNER JOIN KHOA ON GIANGVIEN.MaKhoa = KHOA.MaKhoa	
	SELECT * FROM XEMM_DS_GIANGVIEN
	--4.Hiển thị danh sách các giảng viên giảng dạy các môn học (Tên giảng viên, tên khoa, tên môn học)
	CREATE VIEW XEMM_DS_GIANGVIEN_MH
	AS
	SELECT GIANGVIEN.HoTenGV, KHOA.TenKhoa, MONHOC.TenMon
	FROM 
	MONHOC INNER JOIN GIANGDAY ON MONHOC.MaMon = GIANGDAY.MaMon
	 INNER JOIN GIANGVIEN ON GIANGVIEN.MaGV = GIANGDAY.MaGV
	 INNER JOIN KHOA ON GIANGVIEN.MaKhoa = KHOA.MaKhoa	
	SELECT * FROM XEMM_DS_GIANGVIEN_MH
	--5.Hiển thị danh sách các giảng viên không dạy môn học nào trong năm học 2011-2012
	DROP VIEw XEMM_DS_GIANGVIEN_KhongDay20112012;
	CREATE VIEW XEMM_DS_GIANGVIEN_KhongDay20112012 AS
	SELECT GIANGVIEN.MaGV, GIANGVIEN.HoTenGV, GIANGVIEN.MaKhoa
	FROM GIANGVIEN
	LEFT JOIN GIANGDAY ON GIANGVIEN.MaGV = GIANGDAY.MaGV
	LEFT JOIN DANGKYHOC ON GIANGDAY.MaMon = DANGKYHOC.MaMon 
    AND DANGKYHOC.NamHoc = '2011-2012'
	WHERE DANGKYHOC.MaMon IS NULL;
	SELECT * FROM XEMM_DS_GIANGVIEN_KhongDay20112012;
--VII.Thực hiện cấp phát quyền cho người dùng trên các view
	USE QUANLY_SINHVIEN
	-- Cấp quyền SELECT cho SV_user trên các view
	GRANT SELECT ON XEMM_DS_SINHVIEN TO SV_user;
	GRANT SELECT ON XEMM_DS_SINHVIEN2 TO SV_user;
	GRANT SELECT ON XEMM_DS_GIANGVIEN TO SV_user;
	GRANT SELECT ON XEMM_DS_GIANGVIEN_MH TO SV_user;
	GRANT SELECT ON XEMM_DS_GIANGVIEN_KhongDay20112012 TO SV_user;
	
	SELECT * FROM XEMM_DS_SINHVIEN;

	-- Cấp toàn quyền cho GV_admin trên các view
	GRANT SELECT, INSERT, UPDATE, DELETE ON XEMM_DS_SINHVIEN TO GV_admin;
	GRANT SELECT, INSERT, UPDATE, DELETE ON XEMM_DS_SINHVIEN2 TO GV_admin;
	GRANT SELECT, INSERT, UPDATE, DELETE ON XEMM_DS_GIANGVIEN TO GV_admin;
	GRANT SELECT, INSERT, UPDATE, DELETE ON XEMM_DS_GIANGVIEN_MH TO GV_admin;
	GRANT SELECT, INSERT, UPDATE, DELETE ON XEMM_DS_GIANGVIEN_KhongDay20112012 TO GV_admin;
--VIII. Viết các thủ tục lưu trữ thực hiện các yêu cầu sau:
	--1.Hiển thị mã tên các môn học được sinh viên Nguyễn Thị Hoài Thu đăng ký học:
	CREATE PROCEDURE sv_NguyenThiHoaiThu
	AS
	BEGIN
	SELECT MONHOC.MaMon, MONHOC.TenMon FROM 
	SINHVIEN INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
	INNER JOIN MONHOC ON MONHOC.MaMon = DANGKYHOC.MaMon
	WHERE SINHVIEN.HoTenSV = N'Nguyễn Thị Hoài Thu'
	END
	EXEC sv_NguyenThiHoaiThu
	--2.Đếm số môn học mà sinh viên Trần Ngọc Thanh đã đăng ký học (kết quả truyền cho tham số đầu ra của thủ tục)
	CREATE PROCEDURE sv_TranNgocThanh
	AS
	BEGIN
	SELECT COUNT(*) AS SoLuongMon FROM 
	SINHVIEN INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
	WHERE SINHVIEN.HoTenSV = N'Trần Ngọc Thanh'
	END
	EXEC sv_TranNgocThanh
	--3.Hiển thị danh sách các sinh viên đăng ký học môn Giải tích 1 trong học kỳ 1 (Trong danh sách cần chứa các thông tin: Mã sinh viên, Họ tên, Tên khoa)
	CREATE PROCEDURE sv_Giaitich1_HK1
	AS
	BEGIN
	SELECT SINHVIEN.MaSV, SINHVIEN.HoTenSV, KHOA.MaKhoa  FROM 
	SINHVIEN INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
	INNER JOIN LOP ON LOP.MaLop = SINHVIEN.MaLop
	INNER JOIN KHOA ON KHOA.MaKhoa = LOP.MaKhoa
	WHERE DANGKYHOC.MaMon = 'GTA1' and DANGKYHOC.Hocky = '1'
	END
	EXEC sv_Giaitich1_HK1
	--4.Hiển thị danh sách sinh viên sắp xếp theo tên khoa, mỗi khoa lại sắp xếp theo họ tên. Danh sách chứa các thông tin sau: mã sinh viên, họ tên sinh viên, tên khoa
	CREATE PROCEDURE DSSV_Sapxep
	AS
	BEGIN
	SELECT SINHVIEN.MaSV, SINHVIEN.HoTenSV, KHOA.TenKhoa
	FROM SINHVIEN INNER JOIN LOP ON SINHVIEN.MaLop = LOP.MaLop
	INNER JOIN KHOA ON LOP.MaKhoa = KHOA.MaKhoa
	ORDER BY 
    KHOA.TenKhoa,    
    SINHVIEN.HoTenSV; 
	END
	EXEC DSSV_Sapxep
	--5.Hiển thị bảng thống kê sinh viên theo khoa.Bảng chứa thông tin mã khoa, tên khoa, số lượng sinh viên.
	CREATE PROCEDURE DSSV_Khoa
	AS
	BEGIN
	SELECT KHOA.MaKhoa, KHOA.TenKhoa, COUNT(SINHVIEN.MaSV) AS SoLuongSV
	FROM SINHVIEN INNER JOIN LOP ON SINHVIEN.MaLop = LOP.MaLop
	INNER JOIN KHOA ON LOP.MaKhoa = KHOA.MaKhoa
	GROUP by KHOA.MaKhoa, KHOA.TenKhoa  
	END
	EXEC DSSV_Khoa
	--6.Hiển thị danh sách các thầy dạy trong từng kỳ. Trong danh sách cần có các thông tin: Họ tên thầy, tên môn, học kỳ, số lượng sinh viên
	CREATE PROCEDURE DSThay_HocKy
	AS
	BEGIN
	SELECT GIANGVIEN.HoTenGV, MONHOC.TenMon, DANGKYHOC.Hocky, COUNT(DANGKYHOC.MaSV) AS SoLuongSinhVien
	FROM GIANGVIEN INNER JOIN DANGKYHOC ON GIANGVIEN.MaGV = DANGKYHOC.MaGV
	INNER JOIN MONHOC ON MONHOC.MaMon = DANGKYHOC.MaMon
	GROUP by GIANGVIEN.HoTenGV, MONHOC.TenMon, DANGKYHOC.Hocky  
	END
	EXEC DSThay_HocKy
	--7.Hiển thị danh sách sinh viên đăng ký nhiều môn học nhất
	CREATE PROCEDURE DSSV_DKMONNhieuNhat
	AS
	BEGIN
		SELECT top 1 SINHVIEN.HoTenSV, SINHVIEN.MaSV, COUNT(*) as SOLUONG
		FROM SINHVIEN INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
		GROUP by SINHVIEN.HoTenSV,SINHVIEN.MaSV
		ORDER BY SOLUONG desc;
	END
	EXEC DSSV_DKMONNhieuNhat
	--8.Đếm số sinh viên đăng ký nhiều môn học nhất/học kỳ (truyền kết quả qua tham số của thủ tục)
	drop procedure DSSV_DKMONNhieuNhat_HK
	CREATE PROCEDURE DSSV_DKMONNhieuNhat_HK
    @Hocky VARCHAR(10)  -- Tham số để truyền học kỳ
	AS
	BEGIN
		SELECT SINHVIEN.HoTenSV, SINHVIEN.MaSV, DANGKYHOC.Hocky, COUNT(DANGKYHOC.MaMon) as SOLUONG
		FROM SINHVIEN 
		INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
		WHERE DANGKYHOC.Hocky = @Hocky  -- Lọc theo học kỳ truyền vào
		GROUP BY SINHVIEN.HoTenSV, SINHVIEN.MaSV, DANGKYHOC.Hocky
		ORDER BY SOLUONG DESC;
	END;
	EXEC DSSV_DKMONNhieuNhat_HK @Hocky = '1'; --VD: Học kỳ 1
	--9.Đếm số giảng viên giảng dạy nhiều môn nhất/ ít môn nhất (Truyền kết quả qua tham số của thủ tục)
	CREATE PROCEDURE DSSV_GIANGVIEN_GIANGDAYSOMON
    @LoaiThongKe VARCHAR(3)  -- Tham số: 'A' cho nhiều môn nhất, 'B' cho ít môn nhất
	AS
	BEGIN
    -- Kiểm tra tham số loại thống kê
    IF @LoaiThongKe = 'A'
    BEGIN
        -- Bước 1: Tìm số môn giảng dạy nhiều nhất
        DECLARE @MaxMon INT;

        -- Lấy số môn giảng dạy nhiều nhất
        SELECT @MaxMon = MAX(SOLUONG)
        FROM (
            SELECT GIANGVIEN.MaGV, COUNT(GIANGDAY.MaMon) AS SOLUONG
            FROM GIANGVIEN
            INNER JOIN GIANGDAY ON GIANGVIEN.MaGV = GIANGDAY.MaGV
            GROUP BY GIANGVIEN.MaGV
        ) AS SubQuery;

        -- Bước 2: Lấy tất cả giảng viên giảng dạy số môn bằng số nhiều nhất
        SELECT GIANGVIEN.HoTenGV, GIANGVIEN.MaGV, COUNT(GIANGDAY.MaMon) AS SoLuongMon
        FROM GIANGVIEN
        INNER JOIN GIANGDAY ON GIANGVIEN.MaGV = GIANGDAY.MaGV
        GROUP BY GIANGVIEN.HoTenGV, GIANGVIEN.MaGV
        HAVING COUNT(GIANGDAY.MaMon) = @MaxMon
        ORDER BY SoLuongMon DESC;  -- Sắp xếp theo số môn giảng dạy
		END
	  ELSE IF @LoaiThongKe = 'B'
	  BEGIN
        -- Bước 1: Tìm số môn giảng dạy ít nhất
        DECLARE @MinMon INT;

        -- Lấy số môn giảng dạy ít nhất
        SELECT @MinMon = MIN(SOLUONG)
        FROM (
            SELECT GIANGVIEN.MaGV, COUNT(GIANGDAY.MaMon) AS SOLUONG
            FROM GIANGVIEN
            INNER JOIN GIANGDAY ON GIANGVIEN.MaGV = GIANGDAY.MaGV
            GROUP BY GIANGVIEN.MaGV
        ) AS SubQuery;

        -- Bước 2: Lấy tất cả giảng viên giảng dạy số môn bằng số ít nhất
        SELECT GIANGVIEN.HoTenGV, GIANGVIEN.MaGV, COUNT(GIANGDAY.MaMon) AS SoLuongMon
        FROM GIANGVIEN
        INNER JOIN GIANGDAY ON GIANGVIEN.MaGV = GIANGDAY.MaGV
        GROUP BY GIANGVIEN.HoTenGV, GIANGVIEN.MaGV
        HAVING COUNT(GIANGDAY.MaMon) = @MinMon
        ORDER BY SoLuongMon ASC;  -- Sắp xếp theo số môn giảng dạy
    END
    ELSE
    BEGIN
        PRINT 'Tham số không hợp lệ!';
    END
	END;

--Giảng viên dạy nhìu môn nhất
EXEC DSSV_GIANGVIEN_GIANGDAYSOMON @LoaiThongKe = 'A';
--Giảng viên dạy ít môn nhất
EXEC DSSV_GIANGVIEN_GIANGDAYSOMON @LoaiThongKe = 'B';

	--10.Hiển thị danh sách sinh viên đăng ký ít môn học nhất
	CREATE PROCEDURE DSSV_DKMONItNhat
	AS
	BEGIN
    -- Tìm số môn học ít nhất mà sinh viên đăng ký
    DECLARE @MinMon INT;
    -- Lấy số môn học ít nhất
    SELECT @MinMon = MIN(SOLUONG)
    FROM (
        SELECT SINHVIEN.MaSV, COUNT(DANGKYHOC.MaMon) AS SOLUONG
        FROM SINHVIEN
        INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
        GROUP BY SINHVIEN.MaSV
    ) AS SubQuery;

    -- Lấy danh sách sinh viên đăng ký ít môn học nhất
    SELECT SINHVIEN.HoTenSV, SINHVIEN.MaSV, COUNT(DANGKYHOC.MaMon) AS SOLUONG
    FROM SINHVIEN
    INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
    GROUP BY SINHVIEN.HoTenSV, SINHVIEN.MaSV
    HAVING COUNT(DANGKYHOC.MaMon) = @MinMon
    ORDER BY SOLUONG ASC;  -- Sắp xếp theo số lượng môn học đăng ký tăng dần
	END;
	EXEC DSSV_DKMONItNhat;
	--11.Các môn học mà có số lượng sinh viên đăng ký trong 1 kỳ nhỏ hơn 2 sẽ không tổ chức lớp. Hãy hiển thị danh sách các môn học bị hủy (trong danh sách có tên môn, học kỳ, số lượng sinh viên đăng ký)
	CREATE PROCEDURE DSSV_MonHocBiHuy
	AS
	BEGIN
    SELECT MONHOC.TenMon, DANGKYHOC.Hocky, COUNT(DANGKYHOC.MaSV) AS SoLuongSV
    FROM MONHOC
    INNER JOIN DANGKYHOC ON MONHOC.MaMon = DANGKYHOC.MaMon
    GROUP BY MONHOC.TenMon, DANGKYHOC.Hocky
    HAVING COUNT(DANGKYHOC.MaSV) < 2 -- Chỉ lấy các môn học có ít hơn 2 sinh viên đăng ký
    ORDER BY DANGKYHOC.Hocky, MONHOC.TenMon;
	END;
	EXEC DSSV_MonHocBiHuy;
	--12.Đưa ra họ tên, tên lớp và số điểm trung bình của sinh viên có điểm trung bình lớn nhất trong học từng học kỳ/năm học (Các tham số đầu vào, đầu ra được truyền qua tham số của thủ tục)
	CREATE PROCEDURE DSSV_DTBCaoNhat_HK_NH
    @HocKy smallint,  -- Tham số đầu vào: Học kỳ
    @NamHoc CHAR(9)  -- Tham số đầu vào: Năm học
	AS
	BEGIN
    SELECT TOP 1 SINHVIEN.HoTenSV,LOP.TenLop,AVG(DANGKYHOC.Diem) AS DiemTrungBinh
    FROM SINHVIEN
    INNER JOIN DANGKYHOC ON SINHVIEN.MaSV = DANGKYHOC.MaSV
    INNER JOIN LOP ON SINHVIEN.MaLop = LOP.MaLop
    WHERE DANGKYHOC.Hocky = @HocKy AND DANGKYHOC.NamHoc = @NamHoc
    GROUP BY SINHVIEN.HoTenSV, LOP.TenLop
    ORDER BY DiemTrungBinh DESC;
	END;
	EXEC DSSV_DTBCaoNhat_HK_NH @HocKy = '1', @NamHoc = '2012-2013';
	EXEC DSSV_DTBCaoNhat_HK_NH @HocKy = '2', @NamHoc = '2012-2013';









