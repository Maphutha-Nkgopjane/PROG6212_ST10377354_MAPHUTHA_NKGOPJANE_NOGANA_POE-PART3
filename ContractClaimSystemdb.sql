-- =============================================
-- CONSTRUCTION CLAIMS SYSTEM - COMPLETE SETUP
-- =============================================

PRINT '=== CONSTRUCTION CLAIMS SYSTEM - FINAL SETUP ===';

-- =============================================
-- 1. CREATE ALL ROLES
-- =============================================

PRINT '1. Creating all roles...';

-- Insert all required roles for the construction claims system
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
SELECT NEWID(), 'Admin', 'ADMIN', NEWID()
WHERE NOT EXISTS (SELECT 1 FROM AspNetRoles WHERE Name = 'Admin');

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
SELECT NEWID(), 'HR', 'HR', NEWID()
WHERE NOT EXISTS (SELECT 1 FROM AspNetRoles WHERE Name = 'HR');

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
SELECT NEWID(), 'ProjectManager', 'PROJECTMANAGER', NEWID()
WHERE NOT EXISTS (SELECT 1 FROM AspNetRoles WHERE Name = 'ProjectManager');

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
SELECT NEWID(), 'ConstructionManager', 'CONSTRUCTIONMANAGER', NEWID()
WHERE NOT EXISTS (SELECT 1 FROM AspNetRoles WHERE Name = 'ConstructionManager');

INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
SELECT NEWID(), 'Worker', 'WORKER', NEWID()
WHERE NOT EXISTS (SELECT 1 FROM AspNetRoles WHERE Name = 'Worker');

PRINT '✅ All roles created successfully!';
GO

-- =============================================
-- 2. ASSIGN ROLES TO USERS
-- =============================================

PRINT '2. Assigning roles to users...';

-- HR User
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id 
FROM AspNetUsers u, AspNetRoles r 
WHERE u.Email = 'hr@construction.com' AND r.Name = 'HR'
AND NOT EXISTS (SELECT 1 FROM AspNetUserRoles ur WHERE ur.UserId = u.Id AND ur.RoleId = r.Id);

-- Project Manager
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id 
FROM AspNetUsers u, AspNetRoles r 
WHERE u.Email = 'projectmanager@construction.com' AND r.Name = 'ProjectManager'
AND NOT EXISTS (SELECT 1 FROM AspNetUserRoles ur WHERE ur.UserId = u.Id AND ur.RoleId = r.Id);

-- Construction Manager
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id 
FROM AspNetUsers u, AspNetRoles r 
WHERE u.Email = 'constructionmanager@construction.com' AND r.Name = 'ConstructionManager'
AND NOT EXISTS (SELECT 1 FROM AspNetUserRoles ur WHERE ur.UserId = u.Id AND ur.RoleId = r.Id);

-- Worker
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id 
FROM AspNetUsers u, AspNetRoles r 
WHERE u.Email = 'worker@construction.com' AND r.Name = 'Worker'
AND NOT EXISTS (SELECT 1 FROM AspNetUserRoles ur WHERE ur.UserId = u.Id AND ur.RoleId = r.Id);

-- Admin (your account)
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id 
FROM AspNetUsers u, AspNetRoles r 
WHERE u.Email = 'nkgopjane@gmail.com' AND r.Name = 'Admin'
AND NOT EXISTS (SELECT 1 FROM AspNetUserRoles ur WHERE ur.UserId = u.Id AND ur.RoleId = r.Id);

PRINT '✅ All roles assigned successfully!';
GO

-- =============================================
-- 3. UPDATE EMPLOYEE PROFILES WITH REAL DATA
-- =============================================

PRINT '3. Updating employee profiles with real construction data...';

-- HR Profile
UPDATE EmployeeProfiles 
SET 
    UserId = (SELECT Id FROM AspNetUsers WHERE Email = 'hr@construction.com'),
    Name = 'Emily',
    Surname = 'Brown', 
    Department = 'Human Resources',
    DefaultRatePerJob = 250.00,
    RoleName = 'HR'
WHERE Id = 1;

-- Project Manager Profile
UPDATE EmployeeProfiles 
SET 
    UserId = (SELECT Id FROM AspNetUsers WHERE Email = 'projectmanager@construction.com'),
    Name = 'Sarah',
    Surname = 'Johnson',
    Department = 'Project Management', 
    DefaultRatePerJob = 300.00,
    RoleName = 'ProjectManager'
WHERE Id = 2;

-- Construction Manager Profile
UPDATE EmployeeProfiles 
SET 
    UserId = (SELECT Id FROM AspNetUsers WHERE Email = 'constructionmanager@construction.com'),
    Name = 'James',
    Surname = 'Wilson',
    Department = 'Construction Management',
    DefaultRatePerJob = 350.00,
    RoleName = 'ConstructionManager'
WHERE Id = 3;

-- Worker Profile
UPDATE EmployeeProfiles 
SET 
    UserId = (SELECT Id FROM AspNetUsers WHERE Email = 'worker@construction.com'),
    Name = 'John',
    Surname = 'Smith',
    Department = 'Construction Operations',
    DefaultRatePerJob = 150.00,
    RoleName = 'Worker'
WHERE Id = 4;

PRINT '✅ Employee profiles updated successfully!';
GO

-- =============================================
-- 4. ADD SAMPLE CONSTRUCTION WORK CLAIMS
-- =============================================

PRINT '4. Adding sample construction work claims...';

-- Worker Claims
INSERT INTO WorkClaims (WorkerUserId, Name, Surname, Department, RatePerJob, NumberOfJobs, TotalAmount, Status, CreatedAt)
SELECT 
    u.Id,
    'John',
    'Smith',
    'Construction Operations',
    150.00,
    20,
    3000.00,
    'Submitted',
    GETDATE()
FROM AspNetUsers u 
WHERE u.Email = 'worker@construction.com'
AND NOT EXISTS (SELECT 1 FROM WorkClaims WHERE WorkerUserId = u.Id AND Status = 'Submitted');

INSERT INTO WorkClaims (WorkerUserId, Name, Surname, Department, RatePerJob, NumberOfJobs, TotalAmount, Status, CreatedAt)
SELECT 
    u.Id,
    'John', 
    'Smith',
    'Construction Operations',
    150.00,
    15,
    2250.00,
    'Approved',
    DATEADD(day, -5, GETDATE())
FROM AspNetUsers u 
WHERE u.Email = 'worker@construction.com'
AND NOT EXISTS (SELECT 1 FROM WorkClaims WHERE WorkerUserId = u.Id AND Status = 'Approved');

-- Construction Manager Claims
INSERT INTO WorkClaims (WorkerUserId, Name, Surname, Department, RatePerJob, NumberOfJobs, TotalAmount, Status, CreatedAt)
SELECT 
    u.Id,
    'James',
    'Wilson',
    'Construction Management',
    350.00,
    8,
    2800.00,
    'In Progress',
    DATEADD(day, -2, GETDATE())
FROM AspNetUsers u 
WHERE u.Email = 'constructionmanager@construction.com'
AND NOT EXISTS (SELECT 1 FROM WorkClaims WHERE WorkerUserId = u.Id AND Status = 'In Progress');

PRINT '✅ Sample work claims added successfully!';
GO

-- =============================================
-- 5. ADD SAMPLE NOTIFICATIONS
-- =============================================

PRINT '5. Adding sample notifications...';

-- Clear existing sample notifications
DELETE FROM Notifications WHERE Message LIKE '%sample%' OR Message LIKE '%construction%';

-- Worker Notifications
INSERT INTO Notifications (Message, TargetRole, IsRead, WorkClaimId, CreatedAt)
SELECT 
    'Your claim for 20 jobs has been submitted for approval',
    'Worker',
    0,
    (SELECT TOP 1 Id FROM WorkClaims WHERE Status = 'Submitted' ORDER BY CreatedAt DESC),
    GETDATE()
WHERE NOT EXISTS (SELECT 1 FROM Notifications WHERE Message LIKE '%submitted for approval%');

-- Project Manager Notifications
INSERT INTO Notifications (Message, TargetRole, IsRead, WorkClaimId, CreatedAt)
VALUES 
    ('New construction claim requires PM review', 'ProjectManager', 0, NULL, GETDATE()),
    ('Site inspection scheduled for Project Alpha', 'ProjectManager', 1, NULL, DATEADD(day, -1, GETDATE()));

-- Construction Manager Notifications
INSERT INTO Notifications (Message, TargetRole, IsRead, WorkClaimId, CreatedAt)
VALUES 
    ('Concrete delivery scheduled for tomorrow 8 AM', 'ConstructionManager', 0, NULL, GETDATE()),
    ('Safety audit completed - all areas compliant', 'ConstructionManager', 1, NULL, DATEADD(day, -1, GETDATE()));

-- HR Notifications
INSERT INTO Notifications (Message, TargetRole, IsRead, WorkClaimId, CreatedAt)
VALUES 
    ('New employee onboarding required', 'HR', 0, NULL, GETDATE()),
    ('Monthly payroll processing due', 'HR', 0, NULL, DATEADD(day, -2, GETDATE()));

PRINT '✅ Sample notifications added successfully!';
GO

-- =============================================
-- 6. ADD FOREIGN KEY CONSTRAINTS
-- =============================================

PRINT '6. Adding foreign key constraints...';

-- Remove existing constraints if they exist
IF OBJECT_ID('FK_EmployeeProfiles_AspNetUsers_UserId', 'F') IS NOT NULL
    ALTER TABLE EmployeeProfiles DROP CONSTRAINT FK_EmployeeProfiles_AspNetUsers_UserId;

-- Add foreign key to AspNetUsers
ALTER TABLE EmployeeProfiles 
ADD CONSTRAINT [FK_EmployeeProfiles_AspNetUsers_UserId] 
FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE;

PRINT '✅ Foreign key constraints added successfully!';
GO

-- =============================================
-- 7. FINAL VERIFICATION
-- =============================================

PRINT '7. Final verification...';

PRINT '=== ROLE ASSIGNMENTS ===';
SELECT u.Email, r.Name as Role
FROM AspNetUsers u
JOIN AspNetUserRoles ur ON u.Id = ur.UserId
JOIN AspNetRoles r ON ur.RoleId = r.Id
ORDER BY u.Email, r.Name;

PRINT '=== EMPLOYEE PROFILES ===';
SELECT 
    ep.Name,
    ep.Surname,
    ep.Department,
    ep.RoleName,
    ep.DefaultRatePerJob,
    u.Email
FROM EmployeeProfiles ep
JOIN AspNetUsers u ON ep.UserId = u.Id
ORDER BY ep.RoleName;

PRINT '=== WORK CLAIMS SUMMARY ===';
SELECT 
    Status,
    COUNT(*) as ClaimCount,
    SUM(TotalAmount) as TotalValue
FROM WorkClaims 
GROUP BY Status;

PRINT '=== NOTIFICATIONS SUMMARY ===';
SELECT 
    TargetRole,
    COUNT(*) as NotificationCount,
    SUM(CASE WHEN IsRead = 0 THEN 1 ELSE 0 END) as UnreadCount
FROM Notifications 
GROUP BY TargetRole;

PRINT '';
PRINT '🎉 CONSTRUCTION CLAIMS SYSTEM SETUP COMPLETE! 🎉';
PRINT '';
PRINT '=== TESTING INSTRUCTIONS ===';
PRINT '1. HR: Login as hr@construction.com';
PRINT '2. Project Manager: Login as projectmanager@construction.com';
PRINT '3. Construction Manager: Login as constructionmanager@construction.com';
PRINT '4. Worker: Login as worker@construction.com';
PRINT '5. Admin: Login as nkgopjane@gmail.com';
PRINT '';
PRINT '✅ All roles assigned';
PRINT '✅ Employee profiles updated';
PRINT '✅ Sample data added';
PRINT '✅ Foreign keys configured';
PRINT '✅ Ready for production use!';