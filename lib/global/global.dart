import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

final FirebaseAuth fauth = FirebaseAuth.instance;
User? currentUser;
UserModel? currentUserModelInfo;
