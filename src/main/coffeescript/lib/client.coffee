bilby = require('bilby')
httpClosure = require('./http')

clientClosure = (@baseUrl, @token) ->
  withSession: (f) ->
    http = httpClosure(baseUrl, token)

    f(Object.freeze(
      # Account functions.
      deleteAccountUser: bilby.bind(http.delete)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/users/#{ i.user_id }")
      getAccount: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }")
      getAccountCourse: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/courses/#{ i.course_id }")
      getAccountCourses: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/courses")
      getAccountMigration: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/content_migrations/#{ i.migration_id }")
      getAccountMigrations: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/content_migrations")
      getAccountSubs: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/sub_accounts")
      getAccountUsers: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
      getAccounts: bilby.bind(http.get)(http, (-> '/api/v1/accounts'), null)
      postAccountCourse: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/courses")
      postAccountMigration: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/content_migrations")
      postAccountSub: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/sub_accounts")
      postAccountUser: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
      putAccount: bilby.bind(http.put)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }")
      putAccountMigration: bilby.bind(http.put)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/content_migrations/#{ i.migration_id }")
      putAccountUsersMerge: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id }/merge_into/accounts/#{ i.destination_account_id }/users/#{ i.destination_user_id }")

      # Course functions.
      deleteCourse: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }")
      deleteCourseAssignment: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/assignments/#{ i.assignment_id }")
      deleteCourseAssignmentGroup: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/assignment_groups/#{ i.assignment_group_id }")
      deleteCourseEnrollment: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/enrollments/#{ i.enrollment_id }")
      deleteCourseExternalTool: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/external_tools/#{ i.external_tool_id }")
      deleteCourseModule: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }")
      deleteCourseModuleItem: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }/items/#{ i.item_id }")
      deleteCourseQuiz: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }")
      deleteCourseQuizQuestion: bilby.bind(http.delete)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }/questions/#{ i.question_id }")
      getCourse: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }")
      getCourses: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/courses")
      getCourseAssignment: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignments/#{ i.assignment_id }")
      getCourseAssignments: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignments")
      getCourseAssignmentGroup: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignment_groups/#{ i.assignment_group_id }")
      getCourseAssignmentGroups: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignment_groups")
      getCourseEnrollments: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/enrollments")
      getCourseExternalTool: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/external_tools/#{ i.external_tool_id }")
      getCourseExternalTools: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/external_tools")
      getCourseFiles: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/files")
      getCourseFilesQuota: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/files/quota")
      getCourseMigration: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/content_migrations/#{ i.migration_id }")
      getCourseMigrations: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/content_migrations")
      getCourseModule: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/modules/#{ i.module_id }")
      getCourseModules: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/modules")
      getCourseModuleItem: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }/items/#{ i.item_id }")
      getCourseModuleItems: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }/items")
      getCourseSettings: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/settings")
      getCourseTodos: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/todo")
      getCourseUser: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/users/#{ i.user_id }")
      getCourseUsers: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/users")
      getCourseQuiz: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/quizzes/#{ i.quiz_id }")
      getCourseQuizzes: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/quizzes")
      getCourseQuizQuestion: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }/questions/#{ i.question_id }")
      getCourseQuizQuestions: bilby.bind(http.get)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }/questions")
      postCourse: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/courses")
      postCourseAssignment: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignments")
      postCourseAssignmentGroup: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/assignment_groups")
      postCourseEnrollment: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/enrollments")
      postCourseExternalTool: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/external_tools")
      postCourseFile: bilby.bind(http.postUrlEncoded)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/files")
      postCourseMigration: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/content_migrations")
      postCourseModule: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/modules")
      postCourseModuleItem: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }/items")
      postCourseQuiz: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/quizzes")
      postCourseQuizQuestion: bilby.bind(http.post)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }/questions")
      putCourse: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }")
      putCourseAssignment: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/assignments/#{ i.assignment_id }")
      putCourseAssignmentGroup: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/assignment_groups/#{ i.assignment_group_id }")
      putCourseExternalTool: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/external_tools/#{ i.external_tool_id }")
      putCourseMigration: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/content_migrations/#{ i.migration_id }")
      putCourseSettings: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id || i }/settings")
      putCourseModule: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }")
      putCourseModuleItem: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/modules/#{ i.module_id }/items/#{ i.item_id }")
      putCourseQuiz: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }")
      putCourseQuizQuestion: bilby.bind(http.put)(http, (i) -> "/api/v1/courses/#{ i.course_id }/quizzes/#{ i.quiz_id }/questions/#{ i.question_id }")

      # File functions.
      deleteFile: bilby.bind(http.delete)(http, (i) -> "/api/v1/files/#{ i.file_id || i }")
      getFile: bilby.bind(http.get)(http, (i) -> "/api/v1/files/#{ i.file_id || i }")
      putFile: bilby.bind(http.put)(http, (i) -> "/api/v1/files/#{ i.file_id || i }")

      # Section functions.
      deleteSectionEnrollment: bilby.bind(http.delete)(http, (i) -> "/api/v1/sections/#{ i.section_id }/enrollments/#{ i.enrollment_id }")
      getSectionEnrollments: bilby.bind(http.get)(http, (i) -> "/api/v1/sections/#{ i.section_id || i }/enrollments")
      postSectionEnrollment: bilby.bind(http.post)(http, (i) -> "/api/v1/sections/#{ i.section_id || i }/enrollments")

      # Self functions.
      deleteSelfStreamItem: bilby.bind(http.delete)(http, (i) -> "/api/v1/users/self/activity_stream/#{ i.item_id || i }")
      deleteSelfStreamItems: bilby.bind(http.delete)(http, (-> '/api/v1/users/self/activity_stream'), null)
      getSelfCourses: bilby.bind(http.get)(http, (-> '/api/v1/courses'), null)
      getSelfEvents: bilby.bind(http.get)(http, (-> '/api/v1/users/self/upcoming_events'), null)
      getSelfStreamItems: bilby.bind(http.get)(http, (-> '/api/v1/users/self/activity_stream'), null)
      getSelfStreamItemsSummary: bilby.bind(http.get)(http, (-> '/api/v1/users/self/activity_stream/summary'), null)
      getSelfTodos: bilby.bind(http.get)(http, (-> '/api/v1/users/self/todo'), null)
      postSelfFile: bilby.bind(http.postUrlEncoded)(http, (-> '/api/v1/users/self/files'), null)

      # User functions.
      deleteUser: bilby.bind(http.delete)(http, (i) -> "/api/v1/accounts/#{ i.account_id }/users/#{ i.user_id }")
      deleteUserCustom: bilby.bind(http.delete)(http, (i) -> "/api/v1/users/#{ i.user_id } /custom_data/#{ i.scope }")
      getUser: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/profile")
      getUserAvatars: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/avatars")
      getUserCustom: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id }/custom_data/#{ i.scope }")
      getUserEnrollments: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/enrollments")
      getUserFiles: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/files")
      getUserFilesQuota: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/files/quota")
      getUserLogins: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/logins")
      getUserMigration: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id }/content_migrations/#{ i.migration_id }")
      getUserMigrations: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/content_migrations")
      getUserPageViews: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/page_views")
      getUserProfile: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/profile")
      getUserSettings: bilby.bind(http.get)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/settings")
      getUsers: bilby.bind(http.get)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
      postUser: bilby.bind(http.post)(http, (i) -> "/api/v1/accounts/#{ i.account_id || i }/users")
      postUserFile: bilby.bind(http.postUrlEncoded)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/files")
      postUserMigration: bilby.bind(http.post)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/content_migrations")
      putUser: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id || i }")
      putUserCustom: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id } /custom_data/#{ i.scope }")
      putUserMigration: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id }/content_migrations/#{ i.migration_id }")
      putUserSettings: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id || i }/settings")
      putUsersMerge: bilby.bind(http.put)(http, (i) -> "/api/v1/users/#{ i.user_id }/merge_into/#{ i.destination_user_id }")
    ))

module.exports = Object.freeze(clientClosure)
